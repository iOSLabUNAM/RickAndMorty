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
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.seasonFilter(selectedSeason: "S01")) { episode in
                        EpisodeCard(episode: episode)
                            .frame(width: 300)
                    }
                }
                .padding()
            }
            .navigationTitle("Episodes")
        }
    }
}

struct EpisodeListView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeListView()
    }
}
