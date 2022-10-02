//
//  CharacterRowView.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 09/09/22.
//

import SwiftUI

struct CharacterRowView: View {
    let character: Character
    var body: some View {
        HStack {
            CachedAsyncImage(url: character.imageUrl()) { phase in
                switch phase {
                case .empty:
                    SquareImage(image: Image("character-placeholder"), size: 120, contentMode: .fill)
                            .cornerRadius(5)
                case .success(let image):
                    SquareImage(image: image, size: 120, contentMode: .fill)
                        .cornerRadius(5)
                default:
                    SquareImage(image: Image(systemName: "xmark.icloud"), size: 120, contentMode: .fit)
                }
            }
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.headline)
                    .fontWeight(.bold)
                HStack {
                    Circle()
                        .foregroundColor(statusColor(character.status))
                        .frame(width: 10)
                    Text(character.species)
                }
                .font(.subheadline)
                Text(character.origin?.name ?? "Unkown")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }

    func statusColor(_ status: Character.Status) -> Color {
        switch status {
        case .alive: return .green
        case .dead: return .black
        default: return .gray
        }
    }
}

struct CharacterRowView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRowView(character: TestData().characters[0])
    }
}
