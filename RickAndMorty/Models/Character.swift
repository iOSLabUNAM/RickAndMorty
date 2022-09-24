//
//  Character.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 09/09/22.
//

import Foundation

struct Character: Codable, Identifiable {
    enum Status: String, Codable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }
    struct LocationUrl: Codable {
        let name: String?
        let url: String?
    }
    let id: Int
    let name: String
    let imageUrlString: String
    let status: Status
    let species: String
    let gender: String
    let type: String
    let location: LocationUrl?
    let origin: LocationUrl?
//    let episode: [String]
//    let url: String
//    let created: String

    func imageUrl() -> URL? {
       return URL(string: imageUrlString)
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrlString = "image"
        case status
        case species
        case gender
        case type
        case location
        case origin
    }
}

extension Character: Equatable {
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }
}
