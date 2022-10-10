//
//  Character.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 09/09/22.
//

import Foundation

struct UrlLocation: Codable {
    let name: String?
    let url: String?
}

enum Gender: String, Codable, CaseIterable {
    case all = "All"
    case male = "Male"
    case female = "Female"
    case unknown = "unknown"

    func text() -> String {
        return rawValue.capitalized
    }
}

struct Character: Codable, Identifiable {
    enum Status: String, Codable, CaseIterable {
        case all = "All"
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"

        func text() -> String {
            return rawValue.capitalized
        }
    }
    let id: Int
    let name: String
    let imageUrlString: String
    let status: Status
    let species: String
    let gender: Gender
    let type: String
    let location: UrlLocation?
    let origin: UrlLocation?
    let episodes: [String]
    let url: String
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
        case episodes = "episode"
        case location
        case origin
        case url
    }
}

extension Character: Equatable {
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }
}
