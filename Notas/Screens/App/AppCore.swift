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
    var starredState: StarredState
    
    init() {
        self.notesState = NotesState()
        self.starredState = StarredState()
        self.selection = .notes
    }
}

enum AppAction: Equatable {
    case tabChange(Selection)
    case notes(NotesAction)
    case starred(StarredAction)
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
    starredReducer.pullback(state: \.starredState, action: /AppAction.starred, environment: { environment in
        StarredEnvironment(realm: environment.realm, mainQueue: environment.mainQueue)
    }),
    notesReducer.pullback(state: \.notesState, action: /AppAction.notes, environment: { environment in
        NotesEnvironment(realm: environment.realm, mainQueue: environment.mainQueue)
    }),
    Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
        switch action {
        case .tabChange(let selection):
            state.selection = selection
            return .none
        default:
            return .none
        }
    }
)


