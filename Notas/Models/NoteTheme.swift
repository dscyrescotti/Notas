//
//  NoteTheme.swift
//  Notas
//
//  Created by Dscyre Scotti on 18/07/2021.
//

import SwiftUI

enum NoteTheme: String {
    case jasmine = "#ffda85"
    case yellow_crayola = "#ffeb99"
    case peach_puff = "#ffd7b2"
    case pink = "#fec2ca"
    case pale_pink = "#ffd6d6"
    case baby_blue = "#99dbff"
    case aero_blue = "#bbf2e6"
    case tea_green = "#c2ffcc"
}

extension NoteTheme {
    static var colors: [Color] {
        [Color(hex: jasmine.rawValue), Color(hex: pink.rawValue), Color(hex: baby_blue.rawValue)]
    }
}
