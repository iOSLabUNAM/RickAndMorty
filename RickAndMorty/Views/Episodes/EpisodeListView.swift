//
//  EpisodeListView.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 09/09/22.
//

import SwiftUI

struct EpisodeListView: View {
    @StateObject var viewModel = EpisodeListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.episodes) { episode in
                VStack(alignment: .leading) {
                    Text(episode.name)
                        .font(.headline)
                    Text(episode.episode)
                        .font(.subheadline)
                    
                    ScrollView(.horizontal) {
                        HStack (spacing: 20) {
                            ForEach(viewModel.tvMazeEpisodes.suffix(10)) { tv in
                                EpisodeImage(urlImg: tv.image?.original ?? "" )
                            }
                        }
                    }
//                    ScrollView(.horizontal) {
//                        HStack (spacing: 20){
//                                ForEach(
//                                    0...10,
//                                    id: \.self
//                                ) {_ in
//                                    EpisodeImage(urlImg:  "https://www.unionjalisco.mx/wp-content/uploads/2021/05/cintura_ariadne_4.jpg")
//
//                                }
//                            }
//                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Episodes")
        }
        .task {
            await viewModel.load()
            await viewModel.loadTvMaze()
        }
    }
}

struct EpisodeListView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeListView()
    }
}

struct EpisodeImage: View {
    let urlImg: String
    
    var body: some View {
        
        debugPrint(urlImg)
        let urlObject = URL(string: urlImg)
        
            return CachedAsyncImage(url: urlObject) { phase in
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
    }
}
