//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 09/09/22.
//

import SwiftUI

struct CharacterListView: View {
    var characters: [Character] = []
    var body: some View {
        List(characters) { character in
            CharacterRowView(character: character)
        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView(characters: TestData().characters)
    }
}
