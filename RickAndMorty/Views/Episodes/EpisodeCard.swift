//
//  EpisodeCard.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 10/10/22.
//

import SwiftUI

struct EpisodeCard: View {
    var episode: Episode

    var body: some View {
        return ZStack(alignment: .bottomLeading) {
            CachedAsyncImage(url: episode.imageUrl) { phase in
                switch phase {
                case .empty:
                    Color("SteelBlue")
                        .opacity(0.3)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .clipped()
                default:
                    Image("character-placeholder")
                        .resizable()
                        .scaledToFit()
                }
            }
            Color(.black)
                .opacity(0.5)
                .frame(height: 70)
            VStack(alignment: .leading) {
                Text(episode.name)
                    .font(.headline)
                    .fontWeight(.bold)
                Text(episode.episode)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .padding()
        }
        .cornerRadius(10)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
               .stroke(Color("CeruleanBlue"), lineWidth: 2)
               .padding([.top, .horizontal])
        }
    }
}

struct EpisodeCard_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeCard(episode: TestData().episodes.first!)
            .padding()
    }
}
