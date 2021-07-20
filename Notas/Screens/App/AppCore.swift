//
//  AppCore.swift
//  Notas
//
//  Created by Dscyre Scotti on 18/07/2021.
//

import SwiftUI
import ComposableArchitecture
import Combine
import RealmSwift

struct AppState: Equatable {
    var selection: Selection
    var notesState: NotesState
    var isActive: Bool
    
    init() {
        self.notesState = NotesState()
        self.selection = .notes
        self.isActive = false
    }
}

enum AppAction: Equatable {
    case tabChange(Selection)
    case notes(NotesAction)
    case isActiveChange(Bool)
    case load
    case notesChange([Note])
}

struct AppEnvironment {
    let realm: Realm
    let mainQueue: AnySchedulerOf<DispatchQueue>
    
    init() {
        self.realm = try! Realm()
        self.mainQueue = AnyScheduler.main
    }
}

let appReducer: Reducer<AppState, AppAction, AppEnvironment> = .combine(
    notesReducer.pullback(state: \.notesState, action: /AppAction.notes, environment: { envrionment in
        NotesEnvironment(realm: envrionment.realm, mainQueue: envrionment.mainQueue)
    }),
    Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
        switch action {
        case .tabChange(let selection):
            state.selection = selection
            return .none
        case .isActiveChange(let isActive):
            state.isActive = isActive
            if !isActive {
                return .init(value: .load)
            }
            return .none
        case .load:
            return environment.realm
                .fetch(NoteObject.self)
                .map { results -> AppAction in
                    let notes = Array(results.map { $0.note })
                    return .notesChange(notes)
                }
                .eraseToEffect()
        case .notesChange(let notes):
            state.notesState.notes = IdentifiedArray(uniqueElements: notes.map { NoteState(.edit($0)) })
            return .none
        default:
            return .none
        }
    }
).debug()


