//
//  NoteView.swift
//  Notas
//
//  Created by Dscyre Scotti on 18/07/2021.
//

import SwiftUI
import ComposableArchitecture

struct NoteView: View {
    @Environment(\.presentationMode) private var presentationMode
    let store: Store<NoteState, NoteAction>
    var body: some View {
        WithViewStore(store, content: { viewStore in
            VStack(spacing: 0) {
                VStack(spacing: 5) {
                    ZStack(alignment: .topLeading) {
                        if viewStore.title.isEmpty {
                            Text("Title")
                                .foregroundColor(Color(.gray).opacity(0.7))
                        }
                        TextField("", text: viewStore.binding(get: { $0.title }, send: { .titleChange($0) }))
                    }
                    .font(Font.title.weight(.medium))
                    ZStack(alignment: .topLeading) {
                        if viewStore.body.isEmpty {
                            Text("Note")
                                .foregroundColor(Color(.gray).opacity(0.7))
                        }
                        TextEditor(text: viewStore.binding(get: { $0.body }, send: { .bodyChange($0) }))
                            .scrollContentBackground(.hidden)
                    }
                    .font(.body)
                }
                .accentColor(.black)
                .padding([.horizontal, .top], 15)
                ThemePickerView(theme: viewStore.binding(get: { $0.theme }, send: { .themeChange($0) }))
                    .ignoresSafeArea(.container, edges: .bottom)
            }
            .foregroundColor(.black)
            .background(
                Color(hex: viewStore.theme.rawValue)
                    .ignoresSafeArea()
            )
            .navigationBarItems(
                leading: Button(action: {
                    viewStore.send(.onDisappear)
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrow.backward")
                        .font(Font.headline.weight(.medium))
                })
                .buttonStyle(SpringButtonStyle()),
                trailing: Button(action: {
                    viewStore.send(.starredChange(!viewStore.starred))
                }, label: {
                    Image(systemName: viewStore.starred ? "star.fill" : "star")
                        .font(Font.headline.weight(.medium))
                })
                .buttonStyle(SpringButtonStyle())
            )
            .onAppear {
                viewStore.send(.onAppear)
            }
        })
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Note")
        .navigationBarBackButtonHidden(true)
    }
    
    init(store: Store<NoteState, NoteAction>) {
        self.store = store
        UITextView.appearance().backgroundColor = .clear
        UITextView.appearance().textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: -5)
    }
}

extension NoteView {
    static func storeView(_ mode: Mode) -> Self {
        NoteView(store: .init(initialState: .init(mode), reducer: noteReducer, environment: .init()))
    }
    
    static func storeView(_ mode: Mode, environment: AppEnvironment) -> Self {
        NoteView(store: .init(initialState: .init(mode), reducer: noteReducer, environment: .init()))
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        AppView.storeView()
    }
}

extension UITextView {
    open override var frame: CGRect {
        didSet {
            backgroundColor = .clear
        }
    }
}
