//
//  CharacterListFilterView.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 30/09/22.
//

import SwiftUI

struct CharacterListFilterView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settingsStore: SettingsStore
    @State var selectedStatus: Character.Status = .all
    @State var onlyHuman: Bool = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Properties")) {
                    Picker("Status", selection: $selectedStatus) {
                        ForEach(Character.Status.allCases, id: \.self) { status in
                            Text(status.text())
                        }
                    }
                }
                Section(header: Text("Species")) {
                    Toggle(isOn: $onlyHuman) {
                        Text("Only Humans")
                    }
                }
            }
            .navigationBarTitle("Charaters Filter")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.accentColor)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.settingsStore.characterFilterSelectedStatus = self.selectedStatus.rawValue
                        self.settingsStore.characterFilterOnlyHuman = self.onlyHuman
                        dismiss()
                    } label: {
                        Text("Filter")
                            .foregroundColor(.accentColor)
                    }
                }
            }
            .onAppear {
                self.selectedStatus = Character.Status(rawValue: self.settingsStore.characterFilterSelectedStatus) ?? .all
                self.onlyHuman = self.settingsStore.characterFilterOnlyHuman
            }
        }

    }
}

struct CharacterListFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListFilterView().environmentObject(SettingsStore())
    }
}
