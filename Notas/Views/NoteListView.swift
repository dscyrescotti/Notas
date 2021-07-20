//
//  NoteListView.swift
//  Notas
//
//  Created by Dscyre Scotti on 18/07/2021.
//

import SwiftUI

struct NoteListView: View {
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 15), count: proxy.size.isPortrait(2, 3)), spacing: 15) {
                    ForEach(0..<10, id: \.self) { _ in
                        NavigationLink(destination: NoteView.storeView(.create)) {
                            NoteCardView(note: .init())
                                .frame(height: 200)
                        }
                        .buttonStyle(SpringButtonStyle())
                    }
                }
                .padding(15)
            }
        }
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView()
    }
}
