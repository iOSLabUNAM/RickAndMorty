//
//  EpisodeListViewModel.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 23/09/22.
//

import Foundation
import Amaca

@MainActor
class EpisodeListViewModel: ObservableObject {
    @Published var episodes: [Episode] = []
    @Published var tvMazeEpisodes: [TvMazeEpisode] = []
    var currentPage = 1
    let apiClient = Amaca.Client(Api.rickAndMorty)
    lazy var endpoint: PaginatedListEndpoint<Episode> = {
        return PaginatedListEndpoint<Episode>(client: apiClient, route: "/api/episode")
    }()
    
    let tvMazeEndpoint = Amaca.Endpoint<TvMazeEpisode>(client: Amaca.Client(Api.tvMaze), route: "/shows/216/episodes")

    func load() async {
        guard let response = try? await endpoint.show(page: currentPage) else { return }
        self.episodes.append(contentsOf: response.results)
        self.currentPage += 1
    }

    func loadTvMaze() async {
        guard let tvMazeEpisodes = try? await tvMazeEndpoint.show() else { return }
        
        //let enco = JSONEncoder()
        //let jsonData = try! enco.encode(tvMazeEpisodes.first?.image)
        //debugPrint( String(data: jsonData, encoding: String.Encoding.utf8) ?? "fail" )
        
        //tvMazeEpisodes.forEach{ tv in
        //    debugPrint(tv.image?.medium ?? "fail")
        //}

        self.tvMazeEpisodes.append(contentsOf: tvMazeEpisodes)
    }

    func isLast(episode: Episode) -> Bool {
        if self.episodes.isEmpty { return false }

        return self.episodes.last == episode
    }
}
