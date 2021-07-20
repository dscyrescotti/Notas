//
//  AppCore.swift
//  Notas
//
//  Created by Dscyre Scotti on 18/07/2021.
//

import SwiftUI
import ComposableArchitecture
import Combine

struct AppState: Equatable {
    var selection: Selection
    var notesState: NotesState
    
    init() {
        self.notesState = NotesState()
        self.selection = .notes
    }
}

enum AppAction: Equatable {
    case tabChange(Selection)
    case notes(NotesAction)
}

struct AppEnvironment { }

let appReducer: Reducer<AppState, AppAction, AppEnvironment> = .combine(
    Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
        switch action {
        case .tabChange(let selection):
            state.selection = selection
            return .none
        default:
            return .none
        }
    }
).debug()


