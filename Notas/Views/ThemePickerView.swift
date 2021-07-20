//
//  ThemePickerView.swift
//  Notas
//
//  Created by Dscyre Scotti on 19/07/2021.
//

import SwiftUI

struct ThemePickerView: View {
    @State private var isPresent: Bool = false
    @Binding var theme: NoteTheme
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
                    .frame(width: 35, height: 35)
            }
            .buttonStyle(SpringButtonStyle())
            if isPresent {
                Group {
                    Color(.label)
                        .frame(width: 1.5, height: 35)
                        .transition(.scale)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(NoteTheme.allCases, id: \.self) { theme in
                                Button(action: {
                                    self.theme = theme
                                }) {
                                    ZStack {
                                        Circle()
                                            .foregroundColor(Color(hex: theme.rawValue))
                                        if self.theme == theme {
                                            Image(systemName: "checkmark")
                                                .font(Font.subheadline.bold())
                                        }
                                    }
                                }
                                .buttonStyle(SpringButtonStyle())
                                .frame(width: 35, height: 35)
                            }
                        }
                    }
                    .frame(height: 35)
                    .cornerRadius(17.5)
                    .transition(.scaleX)
                }
            }
        }
        .transition(.move(edge: .bottom))
        .padding(10)
        .background(
            VisualEffectView(effect: UIBlurEffect(style: .systemThickMaterial))
                .cornerRadius(35)
        )
        .clipped()
        .padding(.horizontal, 15)
        .padding(.vertical, 3)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ThemePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ThemePickerView(theme: .constant(.aero_blue))
    }
}

