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
    var selection: AppSelection
    
    init() {
        self.selection = .notes
    }
}

enum AppAction: Equatable {
    case tabChange(AppSelection)
}

struct AppEnvironment { }

let appReducer: Reducer<AppState, AppAction, AppEnvironment> = .combine(
    Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
        switch action {
        case .tabChange(let selection):
            state.selection = selection
            return .none
        }
    }
).debug()

enum AppSelection: Equatable {
    case notes
    case starred
}
