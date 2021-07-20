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

struct NoteState: Equatable {
    let note: Note
    let mode: Mode
    var title: String
    var body: String
    var theme: NoteTheme
    var starred: Bool
    
    init(_ mode: Mode) {
        self.mode = mode
        self.note = mode.note
        self.title = note.title
        self.body = note.body
        self.theme = note.theme
        self.starred = note.starred
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
    
    case transaction(Result<Signal, AppError>)
}

struct NoteEnvironment {
    let realm: Realm
    let mainQueue: AnySchedulerOf<DispatchQueue>
    
    init() {
        self.realm = try! Realm()
        self.mainQueue = AnyScheduler.main
    }
}

let noteReducer = Reducer<NoteState, NoteAction, NoteEnvironment> { state, action, environment in
    switch action {
    case .onAppear:
        if state.mode == .create {
            return .init(value: .create)
        }
        return .none
    case .onDisappear:
        if state.mode == .create, state.body.isEmpty {
            return .init(value: .delete)
        }
        return .none
    
    case .titleChange(let title):
        state.title = title
        return .init(value: .save(.title(title)))
            .throttle(id: CancelToken(), for: .milliseconds(500), scheduler: environment.mainQueue, latest: true)
            .eraseToEffect()
    case .bodyChange(let body):
        state.body = body
        return .init(value: .save(.body(body)))
            .throttle(id: CancelToken(), for: .milliseconds(500), scheduler: environment.mainQueue, latest: true)
            .eraseToEffect()
    case .themeChange(let theme):
        state.theme = theme
        return .init(value: .save(.theme(theme)))
    case .starredChange(let starred):
        state.starred = starred
        return .init(value: .save(.starred(starred)))
        
    case .create:
        return environment.realm
            .create(NoteObject.self, object: state.note.object)
            .catchToEffect()
            .map { NoteAction.transaction($0) }
            .eraseToEffect()
    case .save(let change):
        let (key, value) = change.value
        return environment.realm
            .save(NoteObject.self, value: ["id": state.note.id, key: value])
            .catchToEffect()
            .map { NoteAction.transaction($0) }
            .eraseToEffect()
    case .delete:
        return environment.realm
            .delete(object: state.note.object)
            .catchToEffect()
            .map { NoteAction.transaction($0) }
            .eraseToEffect()
    default:
        return .none
    }
}
