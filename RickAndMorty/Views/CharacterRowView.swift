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
            AsyncImage(url: character.imageUrl()) { phase in
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
                    fatalError()
                }
            }
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.title2)
                    .fontWeight(.bold)
                
                HStack() {
                    Text(character.status)
                    Text(character.species)
                }
                .font(.system(size: 22, weight: .light, design: .rounded))
            }
        }
    }
}

struct SquareImage: View {
    let image: Image
    let size: CGFloat
    let contentMode: ContentMode
    
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: contentMode)
            .frame(width: size, height: size, alignment: .center)
            .clipped()
    }
}

struct CharacterRowView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRowView(character: TestData().characters[0])
    }
}
