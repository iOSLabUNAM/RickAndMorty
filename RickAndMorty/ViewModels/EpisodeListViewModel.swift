//
//  EpisodeListViewModel.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 23/09/22.
//

import Foundation
import Amaca
import Combine

class EpisodeListViewModel: ObservableObject {
    @Published var episodes: [Episode] = []
    @Published private var rawEpisodes: [Episode] = []
    @Published private var tvMazeEpisodes: [TvMazeEpisode] = []
    var currentPage = 1
    let apiClient: Amaca.Client
    let tvMazeClient: Amaca.Client
    let endpoint: PaginatedListEndpoint<Episode>
    let tvMazeEndpoint: Amaca.Endpoint<TvMazeEpisode>

    private var cancellableSet = Set<AnyCancellable>()

    init() {
        self.apiClient = Amaca.Client(Api.rickAndMorty)
        self.endpoint = PaginatedListEndpoint<Episode>(client: self.apiClient, route: "/api/episode")

        self.tvMazeClient = Amaca.Client(Api.tvMaze)
        self.tvMazeEndpoint = Amaca.Endpoint<TvMazeEpisode>(client: self.tvMazeClient, route: "/shows/216/episodes")

        load()
    }

    func load() {
        loadTvMaze()
        loadRickAndMorty()
        Publishers
            .CombineLatest($rawEpisodes, $tvMazeEpisodes)
            .receive(on: RunLoop.main)
            .map { (eps, tveps) in
                return eps.map { ep in
                    var episode = ep
                    let tvep = tveps.first { tvep in tvep.episode == episode.episode }
                    episode.imageUrlString = tvep?.image?.original
                    return episode
                }
            }
            .assign(to: \.episodes, on: self)
            .store(in: &cancellableSet)
    }

    func loadTvMaze() {
        tvMazeEndpoint
            .showPublisher()
            .receive(on: RunLoop.main)
            .sink {
                print("Tv Maze endpoint completed : \($0)")
            } receiveValue: { episodes in
                self.tvMazeEpisodes = episodes
            }
            .store(in: &cancellableSet)
    }

    func loadRickAndMorty() {
        endpoint
            .showPublisher()
            .receive(on: RunLoop.main)
            .sink {
                print("Episodes page loaded \(self.currentPage) : \($0)")
            } receiveValue: { response in
                self.rawEpisodes.append(contentsOf: response.results)
            }
            .store(in: &cancellableSet)
    }

    func isLast(episode: Episode) -> Bool {
        if self.episodes.isEmpty { return false }

        return self.episodes.last == episode
    }
}
