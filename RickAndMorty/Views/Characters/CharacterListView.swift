//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 09/09/22.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject var viewModel = CharacterListViewModel()
    var body: some View {
        NavigationView {
            List(viewModel.characters) { character in
                NavigationLink {
                    CharacterDetail(character: character)
                } label: {
                    CharacterRowView(character: character)
                        .listRowSeparator(.hidden)
                        .onAppear {
                            if viewModel.isLast(character: character) {
                                Task { await viewModel.load() }
                            }
                        }
                }
                .listRowSeparator(.hidden)
            }
            .navigationTitle("Characters")
        }.task {
            await viewModel.load()
        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
