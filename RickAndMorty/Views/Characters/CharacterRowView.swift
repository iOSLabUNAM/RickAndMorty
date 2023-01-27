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
        VStack {
            ZStack{
                CachedAsyncImage(url: character.imageUrl()) { phase in
                    switch phase {
                    case .empty:
                        SquareImage(image: Image("character-placeholder"), size: 120, contentMode: .fill)
                                .cornerRadius(5)
                    case .success(let image):
                            SquareImage(image: image, size: 120, contentMode: .fill)
                                .cornerRadius(20)
                                
                    default:
                        SquareImage(image: Image(systemName: "xmark.icloud"), size: 120, contentMode: .fit)
                    }
                }
                statusColor(character.status).opacity(0.7).cornerRadius(20)
                    .frame(width: 120, height: 120)
            }
                Text(character.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Text(character.species)
                    .font(.subheadline)
            
                Text(character.origin?.name ?? "Unkown")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            
        }
    }

    func statusColor(_ status: Character.Status) -> Color {
        switch status {
        case .dead: return .gray
        default: return .white.opacity(0)
        }
    }
    
}

struct CharacterRowView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRowView(character: TestData().characters[0])
    }
}
