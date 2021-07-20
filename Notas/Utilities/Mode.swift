//
//  Mode.swift
//  Notas
//
//  Created by Dscyre Scotti on 20/07/2021.
//

import Foundation

enum Mode: Equatable {
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
