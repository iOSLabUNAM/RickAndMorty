//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 09/09/22.
//

import SwiftUI

struct CharacterListView: View {
    @EnvironmentObject var settingsStore: SettingsStore
    @StateObject var viewModel = CharacterListViewModel()
    @State var showFilter: Bool = false
    var body: some View {
        NavigationView {
            List(viewModel.characters) { character in
                if shouldShowCharacter(character: character) {
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
            }
            .navigationTitle("Characters")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.showFilter = true
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.title2)
                            .foregroundColor(.accentColor)
                    }

                }
            }.sheet(isPresented: $showFilter) {
                CharacterListFilterView().environmentObject(settingsStore)
            }
        }.task {
            await viewModel.load()
        }
    }

    func shouldShowCharacter(character: Character) -> Bool {
        return shouldShowCharacterStatus(character: character) && shouldShowHumanCharacter(character: character)
    }

    func shouldShowCharacterStatus(character: Character) -> Bool {
        let selectedStatus = Character.Status(rawValue: settingsStore.characterFilterSelectedStatus)
        if selectedStatus == .all {
            return true
        } else {
            return character.status == selectedStatus
        }
    }

    func shouldShowHumanCharacter(character: Character) -> Bool {
        if settingsStore.characterFilterOnlyHuman {
            return character.species == "Human"
        } else {
            return true
        }

    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView().environmentObject(SettingsStore())
    }
}
