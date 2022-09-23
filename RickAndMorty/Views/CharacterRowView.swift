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
                    ProgressView()
                        .frame(width: 120, height: 120, alignment: .center)
                case .success(let image):
                    SquareImage(image: image, size: 120, contentMode: .fill)
                case .failure(let error):
                    #if DEBUG
                    let _ = debugPrint(error)
                    #endif
                    SquareImage(image: Image(systemName: "xmark.icloud"), size: 120, contentMode: .fit)
                @unknown default:
                    SquareImage(image: Image(systemName: "xmark.icloud"), size: 120, contentMode: .fit)
                }
            }
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.headline)
                    .fontWeight(.bold)
                HStack() {
                    Text(character.status.rawValue)
                    Circle()
                        .foregroundColor(statusColor(character.status))
                        .frame(width: 8)
                    Text(character.species)
                }
                .font(.subheadline)
            }
        }
        .cornerRadius(10)
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
