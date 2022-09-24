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
