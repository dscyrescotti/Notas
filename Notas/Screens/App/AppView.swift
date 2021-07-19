//
//  AppView.swift
//  Notas
//
//  Created by Dscyre Scotti on 18/07/2021.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    @Namespace private var namespace
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
                            .font(Font.title.weight(.black))
                            .foregroundColor(Color(.systemBackground))
                            .gradientForeground(colors: .rainbow)
                            .frame(width: 60, height: 60)
                            .background(
                                VisualEffectView(effect: UIBlurEffect(style: .systemThickMaterial))
                                    .cornerRadius(30)
                            )
                    }
                    .buttonStyle(SpringButtonStyle())
                    .padding(15),
                    alignment: .bottomTrailing
                )
            }
            .navigationTitle("Notas")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(Color(.label))
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
