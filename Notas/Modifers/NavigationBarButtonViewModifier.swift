//
//  NavigationButtonViewModifier.swift
//  Notas
//
//  Created by Dscyre Scotti on 19/07/2021.
//

import SwiftUI

struct NavigationBarButtonViewModifier<TrailingItem: View>: ViewModifier {
    @Environment(\.presentationMode) private var presentationMode
    let trailingItem: TrailingItem
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrow.backward")
                        .font(Font.title3.weight(.heavy))
                }),
                trailing: trailingItem
            )
    }
}
