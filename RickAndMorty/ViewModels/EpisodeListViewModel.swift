//
//  EpisodeListViewModel.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 23/09/22.
//

import Foundation
import Amaca
import Combine

extension Amaca {
    struct TvMazeCacheDelegate: CacheResponseDelegate {
        let manager = DataCache()
        let cacheKey = "rick-and-morty-episodes.json"

        func willMakeRequest(urlRequest: URLRequest) {
            // do something
        }

        func fetchCachedRequest(urlRequest: URLRequest) -> Data? {
            return manager.read(key: cacheKey)
        }

        func didFinishRequestSuccessful(data: Data?) {
            guard let data = data else { return }

            manager.write(key: cacheKey, data: data)
        }

        func didFinishRequestUnsuccessful(urlRequest: URLRequest, data: Data?) {
            // do something
        }
    }
}

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

        self.tvMazeClient = {
            var client = Amaca.Client(Api.tvMaze)
            client.cacheDelegate = Amaca.TvMazeCacheDelegate()
            return client
        }()
        self.tvMazeEndpoint = Amaca.Endpoint<TvMazeEpisode>(client: self.tvMazeClient, route: "/shows/216/episodes")

        fetch()
    }

    private func fetch() {
        fetchTvMaze()
        fetchRickAndMorty()
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

    private func fetchTvMaze() {
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

    private func fetchRickAndMorty() {
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

    func seasonFilter(selectedSeason: String? = nil) -> [Episode] {
        guard let season = selectedSeason else { return self.episodes }

        return self.episodes.filter { $0.episode.hasPrefix(season) }
    }

    func isLast(episode: Episode) -> Bool {
        if self.episodes.isEmpty { return false }

        return self.episodes.last == episode
    }
}
