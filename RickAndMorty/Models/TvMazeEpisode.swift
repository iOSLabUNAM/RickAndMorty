//
//  TvMazeEpisode.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 23/09/22.
//

import Foundation

struct TvMazeEpisode: Codable, Identifiable {
    struct Image: Codable {
        let medium: String
        let original: String
    }
    let id: Int
    let season: Int
    let number: Int
    let image: Image?

    var episode: String { "S\(String(format: "%2.2d", self.season))E\(String(format: "%2.2d", self.number))" }
}
