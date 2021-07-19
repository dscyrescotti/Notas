//
//  AnyTransition.swift
//  Notas
//
//  Created by Dscyre Scotti on 19/07/2021.
//

import SwiftUI

extension AnyTransition {
    static var scaleX: AnyTransition {
        get {
            AnyTransition.modifier(active: ScaleXModifier(x: 0), identity: ScaleXModifier(x: 260))
        }
    }
}
