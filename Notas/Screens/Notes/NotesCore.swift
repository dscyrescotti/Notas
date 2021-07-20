//
//  NotesCore.swift
//  Notas
//
//  Created by Dscyre Scotti on 19/07/2021.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct NotesState: Equatable {
    
}

enum NotesAction: Equatable {
    case onAppear
}

struct NotesEnvironment {
    
}

let notesReducer = Reducer<NotesState, NotesAction, NotesEnvironment> { state, action, environment in
    return .none
}
