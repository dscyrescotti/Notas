//
//  NoteCore.swift
//  Notas
//
//  Created by Dscyre Scotti on 19/07/2021.
//

import Foundation
import ComposableArchitecture

struct NoteState: Equatable {
    let id: UUID
    var title: String
    var body: String
    var theme: NoteTheme
    
    init(_ mode: Mode) {
        let note = mode.note
        self.id = note.id
        self.title = note.title
        self.body = note.body
        self.theme = note.theme
    }
}

enum NoteAction: Equatable {
    case onAppear
    
    case titleChange(String)
    case bodyChange(String)
    case themeChange(NoteTheme)
}

struct NoteEnvironment {
    
}

let noteReducer = Reducer<NoteState, NoteAction, NoteEnvironment> { state, action, environment in
    switch action {
    case .onAppear:
        return .none
    case .titleChange(let title):
        state.title = title
        return .none
    case .bodyChange(let body):
        state.body = body
        return .none
    case .themeChange(let theme):
        state.theme = theme
        return .none
    }
}

enum Mode {
    case create
    case edit(Note)
}

extension Mode {
    var note: Note {
        switch self {
        case .create:
            return Note()
        case .edit(let note):
            return note
        }
    }
}
