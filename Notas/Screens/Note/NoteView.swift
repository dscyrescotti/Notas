//
//  NoteView.swift
//  Notas
//
//  Created by Dscyre Scotti on 18/07/2021.
//

import SwiftUI

struct NoteView: View {
    var body: some View {
        VStack {
            TextField("Title", text: .constant(""))
                .font(Font.title.weight(.medium))
            ZStack(alignment: .topLeading) {
                Text("Note")
                    .foregroundColor(Color.gray.opacity(0.6))
                TextEditor(text: .constant(""))
            }
            .font(.body)
        }
        .accentColor(.yellow)
        .foregroundColor(.black)
        .padding(15)
        .navigationBarItems(
            trailing: HStack {
                Button(action: {
                    
                }, label: {
                    Image(systemName: "paintpalette.fill")
                        .font(Font.title3.weight(.heavy))
                        .foregroundColor(Color("reverse"))
                        .gradientForeground(colors: NoteTheme.colors)
                })
                Spacer(minLength: 20)
                Button(action: {
                    
                }, label: {
                    Image(systemName: "star.fill")
                        .font(Font.title3.weight(.heavy))
                })
                .foregroundColor(.yellow)
            }
        )
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(hex: NoteTheme.yellow_crayola.rawValue).ignoresSafeArea())
    }
    
    init() {
        UITextView.appearance().backgroundColor = .clear
        UITextView.appearance().textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: -5)
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
