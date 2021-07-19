//
//  ThemePickerView.swift
//  Notas
//
//  Created by Dscyre Scotti on 19/07/2021.
//

import SwiftUI

struct ThemePickerView: View {
    @State private var isPresent: Bool = false
    var body: some View {
        HStack(spacing: 15) {
            Button(action: {
                withAnimation(Animation.spring()) {
                    isPresent.toggle()
                }
            }) {
                Image(systemName: "paintpalette.fill")
                    .font(Font.title.weight(.medium))
                    .foregroundColor(Color(.systemBackground))
                    .gradientForeground(colors: .rainbow)
                    .frame(width: 30, height: 30)
            }
            .buttonStyle(SpringButtonStyle())
            if isPresent {
                Group {
                    Color(.label)
                        .frame(width: 1.5, height: 30)
                        .transition(.scale)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 15) {
                            ForEach(NoteTheme.allCases, id: \.self) { theme in
                                ZStack {
                                    Circle()
                                        .foregroundColor(Color(hex: theme.rawValue))
                                    Image(systemName: "checkmark")
                                        .font(Font.headline.bold())
                                }
                                .frame(width: 30)
                                .onTapGesture {

                                }
                            }
                        }
                    }
                    .frame(height: 30)
                    .cornerRadius(20)
                    .animation(.spring())
                    .transition(.scaleX)
                }
            }
        }
        .transition(.move(edge: .bottom))
        .padding(15)
        .background(
            VisualEffectView(effect: UIBlurEffect(style: .systemThickMaterial))
                .cornerRadius(35)
        )
        .clipped()
        .padding(15)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ThemePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ThemePickerView()
    }
}

