//
//  AppView.swift
//  Notas
//
//  Created by Dscyre Scotti on 18/07/2021.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    var body: some View {
        NavigationView {
            TabView {
                Group {
                    NotesView()
                        .tabItem {
                            Label(title: {
                                Text("Notes")
                            }, icon: {
                                Image(systemName: "note.text")
                            })
                        }
                    StarredView()
                        .tabItem {
                            Label(title: {
                                Text("Starred")
                            }, icon: {
                                Image(systemName: "star.fill")
                            })
                        }
                }
                .overlay(
                    NavigationLink(destination: NoteView()) {
                        Image(systemName: "pencil")
                            .font(Font.title3.weight(.heavy))
                            .frame(width: 55, height: 55)
                            .background(
                                VisualEffectView(effect: UIBlurEffect(style: .prominent))
                                    .cornerRadius(25.5)
                            )
                    }.padding(),
                    alignment: .bottomTrailing
                )
            }
            .navigationTitle("Notas")
        }
        .accentColor(Color("accent"))
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
