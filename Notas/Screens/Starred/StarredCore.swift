//
//  StarredCore.swift
//  Notas
//
//  Created by Dscyre Scotti on 20/07/2021.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import RealmSwift

struct StarredState: Equatable {
    var notes: IdentifiedArrayOf<NoteState>
    
    init() {
        notes = []
    }
}

enum StarredAction: Equatable {
    case onAppear
    
    case note(id: UUID, action: NoteAction)
    
    case load
    case notesChange([Note])
    
}

struct StarredEnvironment {
    let realm: Realm
    let mainQueue: AnySchedulerOf<DispatchQueue>
}

let starredReducer: Reducer<StarredState, StarredAction, StarredEnvironment> = .combine(
    noteReducer.forEach(state: \.notes, action: /StarredAction.note, environment: { environment in
        NoteEnvironment(realm: environment.realm, mainQueue: environment.mainQueue)
    }),
    .init({ state, action, environment in
        switch action {
        case .onAppear:
            return .init(value: .load)
        case .load:
            return environment.realm
                .fetch(NoteObject.self, predicate: NSPredicate(format: "starred == %@", NSNumber(true)))
                .map { results -> StarredAction in
                    let notes = Array(results.map { $0.note })
                    return .notesChange(notes)
                }
                .eraseToEffect()
        case .notesChange(let notes):
            state.notes = IdentifiedArray(uniqueElements: notes.map { NoteState(.edit($0)) })
            return .none
        case .note(_, .onDisappear):
            return .init(value: .load)
        default:
            return .none
        }
    })
)
