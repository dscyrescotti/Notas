//
//  ScaleXViewModifier.swift
//  Notas
//
//  Created by Dscyre Scotti on 19/07/2021.
//

import SwiftUI

struct ScaleXModifier: ViewModifier {
    let x: CGFloat
    func body(content: Content) -> some View {
        content.frame(width: x)
    }
}
