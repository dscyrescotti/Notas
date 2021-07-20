//
//  Change.swift
//  Notas
//
//  Created by Dscyre Scotti on 20/07/2021.
//

import Foundation

enum Change: Equatable {
    case title(String)
    case body(String)
    case theme(NoteTheme)
    case starred(Bool)
}

extension Change {
    var value: (String, Any) {
        switch self {
        case .title(let value):
            return ("title", value)
        case .body(let value):
            return ("body", value)
        case .theme(let value):
            return ("theme", value)
        case .starred(let value):
            return ("starred", value)
        }
    }
}
