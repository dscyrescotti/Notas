//
//  Note.swift
//  Notas
//
//  Created by Dscyre Scotti on 18/07/2021.
//

import Foundation
import RealmSwift

struct Note: Equatable {
    let id: UUID
    var title: String
    var body: String
    let createdAt: Date
    var theme: NoteTheme
    var starred: Bool = false
    
    init() {
        self.id = .init()
        self.title = ""
        self.body = ""
        self.theme = .allCases.randomElement()!
        self.createdAt = Date()
        self.starred = false
    }
    
    init(id: UUID, title: String, body: String, createdAt: Date, theme: NoteTheme, starred: Bool) {
        self.id = id
        self.title = title
        self.body = body
        self.createdAt = createdAt
        self.theme = theme
        self.starred = starred
    }
}
