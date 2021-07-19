//
//  Note.swift
//  Notas
//
//  Created by Dscyre Scotti on 18/07/2021.
//

import Foundation

struct Note {
    let id: UUID = .init()
    let title: String?
    let body: String?
    let createdAt = Date()
    let theme: NoteTheme
    let starred: Bool = false
}
