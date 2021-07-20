//
//  Database.swift
//  Notas
//
//  Created by Dscyre Scotti on 19/07/2021.
//

import Foundation
import ComposableArchitecture

class Database {
    static let shared: Database = .init()
    
    private init() { }
    
    private var notes: [Note] = [] {
        didSet {
            print("----------Database--------")
            print(notes, "\n")
        }
    }
}

extension Database {
    func save(_ note: Note) {
        if let index = find(note) {
            notes[index] = note
            return
        }
        notes.append(note)
    }
    
    private func find(_ note: Note) -> Int? {
        notes.firstIndex(of: note)
    }
}
