//
//  View+.swift
//  Notas
//
//  Created by Dscyre Scotti on 18/07/2021.
//

import SwiftUI

extension View {
    func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors), startPoint: .leading, endPoint: .trailing))
            .mask(self)
    }
    
    func navigationBarButtonItems() -> some View {
        self.modifier(NavigationBarButtonViewModifier(trailingItem: EmptyView()))
    }
    
    func navigationBarButtonItems<TrailingItem: View>(_ trailingItem: TrailingItem) -> some View {
        self.modifier(NavigationBarButtonViewModifier(trailingItem: trailingItem))
    }
}
