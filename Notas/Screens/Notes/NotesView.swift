//
//  NotesView.swift
//  Notas
//
//  Created by Dscyre Scotti on 18/07/2021.
//

import SwiftUI
import ComposableArchitecture

struct NotesView: View {
    let store: Store<NotesState, NotesAction>
    var body: some View {
        WithViewStore(store) { viewStore in
            GeometryReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 15), count: proxy.size.isPortrait(2, 3)), spacing: 15) {
                        ForEachStore(store.scope(state: { $0.notes }, action: NotesAction.note(id:action:))) { noteStore in
                            WithViewStore(noteStore) { viewStore in
                                NavigationLink(destination: NoteView(store: noteStore)) {
                                    NoteCardView(note: viewStore.mode.note)
                                        .frame(height: 200)
                                }
                                .buttonStyle(SpringButtonStyle())
                            }
                        }
                    }
                    .padding(15)
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

extension NotesView {
    static func storeView(store: Store<NotesState, NotesAction>) -> Self {
        NotesView(store: store)
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        AppView.storeView()
    }
}
