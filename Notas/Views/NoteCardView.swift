//
//  NoteCardView.swift
//  Notas
//
//  Created by Dscyre Scotti on 18/07/2021.
//

import SwiftUI
import ComposableArchitecture

struct NoteCardView: View {
    let store: Store<NoteState, NoteAction>
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
                    Text(viewStore.title.isEmpty ? "Untitle" : viewStore.title)
                        .font(.title3)
                        .lineLimit(2)
                    Spacer()
                    Button(action: {
                        viewStore.send(.starredChange(!viewStore.starred))
                    }) {
                        Image(systemName: "star.fill")
                            .font(.caption2)
                            .foregroundColor(viewStore.starred ? .yellow : .gray)
                            .frame(width: 22, height: 22)
                            .background(
                                VisualEffectView(effect: UIBlurEffect(style: .prominent))
                                    .cornerRadius(11)
                            )
                    }
                    .buttonStyle(SpringButtonStyle())
                }
                Text(viewStore.body)
                    .frame(maxHeight: .infinity, alignment: .topLeading)
                Text(viewStore.createdAt.toString)
                    .font(.footnote)
            }
            .padding(15)
            .background(Color(hex: viewStore.theme.rawValue))
            .cornerRadius(15)
            .foregroundColor(.black)
        }
    }
}

struct NoteCardView_Previews: PreviewProvider {
    static var previews: some View {
        AppView.storeView()
    }
}
