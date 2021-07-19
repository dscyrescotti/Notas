//
//  SpringButtonStyle.swift
//  Notas
//
//  Created by Dscyre Scotti on 19/07/2021.
//

import SwiftUI

struct SpringButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
    }
}
