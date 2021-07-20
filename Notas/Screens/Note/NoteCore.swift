//
//  NoteCore.swift
//  Notas
//
//  Created by Dscyre Scotti on 19/07/2021.
//

import Foundation
import ComposableArchitecture
import RealmSwift
import Combine

struct NoteState: Equatable, Identifiable {
    let id: UUID
    let mode: Mode
    var title: String
    var body: String
    var theme: NoteTheme
    var starred: Bool
    
    init(_ mode: Mode) {
        self.mode = mode
        let note = mode.note
        self.id = note.id
        self.title = note.title
        self.body = note.body
        self.theme = note.theme
        self.starred = note.starred
    }
    
    var object: NoteObject {
        .init(value: ["id": id, "title": title, "body": body, "theme": theme, "starred": starred])
    }
}

enum NoteAction: Equatable {
    case onAppear
    case onDisappear
    
    case change(Change)
    case titleChange(String)
    case bodyChange(String)
    case themeChange(NoteTheme)
    case starredChange(Bool)
    
    case save(Change)
    case create
    case delete
    
    case result(Result<Signal, AppError>)
}

struct NoteEnvironment {
    let realm: Realm
    let mainQueue: AnySchedulerOf<DispatchQueue>
    
    init() {
        self.realm = try! Realm()
        self.mainQueue = AnyScheduler.main
    }
    
    init(realm: Realm, mainQueue: AnySchedulerOf<DispatchQueue>) {
        self.realm = realm
        self.mainQueue = mainQueue
    }
}

let noteReducer = Reducer<NoteState, NoteAction, NoteEnvironment> { state, action, environment in
    struct Cancellable: Hashable { }
    switch action {
    case .onAppear:
        print(state.id)
        if state.mode == .create {
            return .init(value: .create)
        }
        return .none
    case .onDisappear:
        if state.mode == .create, state.body.isEmpty {
            return .concatenate(
                .cancel(id: Cancellable()),
                .init(value: .delete)
            )
        }
        return .concatenate(
            .cancel(id: Cancellable()),
            environment.realm
                .save(NoteObject(value: state.object))
                .catchToEffect()
                .map { NoteAction.result($0) }
                .eraseToEffect()
        )
    
    case .titleChange(let title):
        state.title = title
        return .init(value: .save(.title(title)))
            .throttle(id: Cancellable(), for: .milliseconds(500), scheduler: environment.mainQueue, latest: true)
            .eraseToEffect()
    case .bodyChange(let body):
        state.body = body
        return .init(value: .save(.body(body)))
            .throttle(id: Cancellable(), for: .milliseconds(500), scheduler: environment.mainQueue, latest: true)
            .eraseToEffect()
    case .themeChange(let theme):
        state.theme = theme
        return .init(value: .save(.theme(theme)))
    case .starredChange(let starred):
        state.starred = starred
        return .init(value: .save(.starred(starred)))
        
    case .create:
        return environment.realm
            .create(NoteObject.self, object: state.object)
            .catchToEffect()
            .map { NoteAction.result($0) }
            .eraseToEffect()
    case .save(let change):
        let (key, value) = change.value
        return environment.realm
            .save(NoteObject.self, value: ["id": state.id, key: value])
            .catchToEffect()
            .map { NoteAction.result($0) }
            .eraseToEffect()
    case .delete:
        return environment.realm
            .delete(NoteObject.self, id: state.id)
            .catchToEffect()
            .map { NoteAction.result($0) }
            .eraseToEffect()
    default:
        return .none
    }
}
