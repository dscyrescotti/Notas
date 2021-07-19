//
//  NoteCardView.swift
//  Notas
//
//  Created by Dscyre Scotti on 18/07/2021.
//

import SwiftUI

struct NoteCardView: View {
    let note: Note
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(note.title ?? "Untitle")
                    .font(.title3)
                Spacer()
                Image(systemName: "star.fill")
                    .font(.footnote)
                    .foregroundColor(!note.starred ? .yellow : .gray)
                    .padding(3)
                    .background(Circle())
            }
            Text(note.body ?? "Note")
                .frame(maxHeight: .infinity, alignment: .topLeading)
            Text(note.createdAt.toString)
                .font(.footnote)
        }
        .padding(15)
        .background(Color(hex: note.theme.rawValue))
        .cornerRadius(15)
        .foregroundColor(.black)
    }
}

struct NoteCardView_Previews: PreviewProvider {
    static var previews: some View {
        NoteCardView(note: Note(title: nil, body: nil, theme: .tea_green))
            .previewLayout(.fixed(width: 250, height: 300))
    }
}
