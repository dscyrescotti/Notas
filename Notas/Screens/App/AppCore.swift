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
    
}

enum AppAction: Equatable {
    
}

struct AppEnvironment {
    
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    default:
        return .none
    }
}
