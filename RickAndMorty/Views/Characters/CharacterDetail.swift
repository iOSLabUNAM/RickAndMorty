//
//  CharacterDetail.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 23/09/22.
//

import SwiftUI

struct CharacterDetail: View {
    let character: Character
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                CachedAsyncImage(url: character.imageUrl()) { phase in
                    switch phase {
                    case .empty:
                        Color("SteelBlue")
                            .opacity(0.3)
                            .frame(width: .infinity, height: 350)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 350)
                            .clipped()
                    default:
                        Image(systemName: "xmark.icloud")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 350)
                            .clipped()
                        }
                }
                HStack {
                    Image(systemName: "heart.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .opacity(0.8)
                            .foregroundColor(statusColor(character.status))
                    Spacer()
                }
            }
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                HStack {
                    Text("\(character.species) - \(character.gender)")
                    Spacer()
                }
                .font(.title2)
            }.padding()
            Spacer()
        }
    }

    func statusColor(_ status: Character.Status) -> Color {
      switch status {
      case .alive: return Color("GreenPigment")
      case .dead: return .black
      default: return Color("SteelBlue")
      }
    }
}

struct CharacterDetail_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetail(character: TestData().characters[0])
    }
}
