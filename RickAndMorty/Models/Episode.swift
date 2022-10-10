//
//  Episode.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 09/09/22.
//

import Foundation

struct Episode: Codable, Identifiable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    var imageUrlString: String?
    var imageUrl: URL? {
        guard let url = self.imageUrlString else { return nil }
        return URL(string: url)
    }
}

extension Episode: Equatable {
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.id == rhs.id
    }
}
