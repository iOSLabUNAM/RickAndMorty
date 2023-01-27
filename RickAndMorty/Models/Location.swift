//
//  Location.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 09/09/22.
//

import Foundation

struct Location: Codable, Identifiable {
    let id: Int
    let name: String
//    let residents: [String]
    let dimension: String
    let type: String
//    let created: String
}
