//
//  AppView.swift
//  Notas
//
//  Created by Dscyre Scotti on 18/07/2021.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    let store: Store<AppState, AppAction>
    var body: some View {
        NavigationStack {
            WithViewStore(store) { viewStore in
                TabView(selection: viewStore.binding(get: { $0.selection }, send: { .tabChange($0) })) {
                    Group {
                        NotesView(store: notesStore)
                            .tabItem {
                                Label(title: {
                                    Text("Notes")
                                }, icon: {
                                    Image(systemName: "note.text")
                                })
                            }
                            .tag(Selection.notes)
                        StarredView(store: starredStore)
                            .tabItem {
                                Label(title: {
                                    Text("Starred")
                                }, icon: {
                                    Image(systemName: "star.fill")
                                })
                            }
                            .tag(Selection.starred)
                    }
                    .overlay(
                        NavigationLink(destination: NoteView.storeView(.create)) {
                            Image(systemName: "pencil")
                                .font(Font.title.weight(.black))
                                .foregroundColor(Color(.systemBackground))
                                .gradientForeground(colors: .rainbow)
                                .frame(width: 55, height: 55)
                                .background(
                                    VisualEffectView(effect: UIBlurEffect(style: .systemThickMaterial))
                                        .cornerRadius(27.5)
                                )
                        }
                        .buttonStyle(SpringButtonStyle())
                        .padding([.horizontal, .bottom], 15),
                        alignment: .bottomTrailing
                    )
                }
                .navigationTitle("Notas")
            }
        }
        .accentColor(Color(.label))
    }
}

extension AppView {
    static func storeView() -> Self {
        .init(store: .init(initialState: .init(), reducer: appReducer, environment: .init()))
    }
    
    var notesStore: Store<NotesState, NotesAction> {
        store.scope(state: { $0.notesState }, action: AppAction.notes)
    }
    
    var starredStore: Store<StarredState, StarredAction> {
        store.scope(state: { $0.starredState }, action: AppAction.starred)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView.storeView()
    }
}
