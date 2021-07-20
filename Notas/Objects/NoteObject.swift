//
//  NoteObject.swift
//  Notas
//
//  Created by Dscyre Scotti on 19/07/2021.
//

import RealmSwift
import Foundation

class NoteObject: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var title: String
    @Persisted var body: String
    @Persisted var createdAt: Date
    @Persisted var theme: NoteTheme
    @Persisted var starred: Bool
}

extension NoteObject {
    var note: Note {
        .init(id: id, title: title, body: body, createdAt: createdAt, theme: theme, starred: starred)
    }
}
