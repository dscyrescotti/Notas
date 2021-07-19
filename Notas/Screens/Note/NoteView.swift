//
//  NoteView.swift
//  Notas
//
//  Created by Dscyre Scotti on 18/07/2021.
//

import SwiftUI

struct NoteView: View {
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        VStack {
            VStack {
                ZStack(alignment: .topLeading) {
                    Text("Title")
                        .foregroundColor(Color.gray.opacity(0.6))
                    TextField("", text: .constant(""))
                }
                .font(Font.title.weight(.medium))
                ZStack(alignment: .topLeading) {
                    Text("Note")
                        .foregroundColor(Color.gray.opacity(0.6))
                    TextEditor(text: .constant(""))
                }
                .font(.body)
            }
            .accentColor(.black)
            .padding(15)
            ThemePickerView()
                .ignoresSafeArea(.container, edges: .bottom)
        }
        .foregroundColor(.black)
        .background(
            Color(hex: NoteTheme.pale_pink.rawValue)
                .ignoresSafeArea()
        )
        .navigationBarButtonItems(
            Button(action: {
                
            }, label: {
                Image(systemName: "star.fill")
                    .font(Font.title3.weight(.heavy))
            })
            .buttonStyle(SpringButtonStyle())
            .foregroundColor(.yellow)
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Note")
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
