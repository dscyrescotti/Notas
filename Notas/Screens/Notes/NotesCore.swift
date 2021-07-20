//
//  NotesCore.swift
//  Notas
//
//  Created by Dscyre Scotti on 19/07/2021.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import RealmSwift

struct NotesState: Equatable {
    var notes: IdentifiedArrayOf<NoteState>
    
    init() {
        notes = []
    }
}

enum NotesAction: Equatable {
    case onAppear
    
    case note(id: UUID, action: NoteAction)
    
    case load
    case notesChange([Note])
    
}

struct NotesEnvironment {
    let realm: Realm
    let mainQueue: AnySchedulerOf<DispatchQueue>
}

let notesReducer: Reducer<NotesState, NotesAction, NotesEnvironment> = .combine(
    noteReducer.forEach(state: \.notes, action: /NotesAction.note, environment: { environment in
        NoteEnvironment(realm: environment.realm, mainQueue: environment.mainQueue)
    }),
    .init({ state, action, environment in
        switch action {
        case .onAppear:
            if state.notes.isEmpty {
                return .init(value: .load)
            }
            return .none
        case .load:
            return environment.realm
                .fetch(NoteObject.self)
                .map { results -> NotesAction in
                    let notes = Array(results.map { $0.note })
                    return .notesChange(notes)
                }
                .eraseToEffect()
        case .notesChange(let notes):
            state.notes = IdentifiedArray(uniqueElements: notes.map { NoteState(.edit($0)) })
            return .none
        case .note(let id, .onDisappear):
            print(id)
            return .init(value: .load)
        default:
            return .none
        }
    })
)
