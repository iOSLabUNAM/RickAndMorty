//
//  EpisodeListView.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 09/09/22.
//

import SwiftUI

struct EpisodeListView: View {
    @ObservedObject var viewModel = EpisodeListViewModel()
    var body: some View {
        NavigationView {
            List(viewModel.episodes) { episode in
                EpisodeCard(episode: episode)
                    .frame(minHeight: 180)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("Episodes")
        }
    }
}

struct EpisodeListView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeListView()
    }
}
