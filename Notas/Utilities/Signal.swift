//
//  Signal.swift
//  Notas
//
//  Created by Dscyre Scotti on 20/07/2021.
//

import Foundation

struct Signal: Equatable { }

extension Signal {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return true
    }
    
    static var signal: Self {
        Self()
    }
}
