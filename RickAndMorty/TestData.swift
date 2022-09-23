//
//  TestData.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 09/09/22.
//

import Foundation

#if DEBUG
struct TestData {
    let characters = [
        Character(
            id: 1,
            name: "Rick Sanchez",
            imageUrlString: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            status: Character.Status.alive,
            species: "Human",
            gender: "Male",
            type: ""
        ),
        Character(
            id: 2,
            name: "Morty Smith",
            imageUrlString: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
            status: Character.Status.alive,
            species: "Human",
            gender: "Male",
            type: ""
        )
    ]
    let locations = [
        Location(
            id: 1,
            name: "Earth (C-137)",
            dimension: "Dimension C-137",
            type: "Planet"
        ),
        Location(
            id: 2,
            name: "Abadango",
            dimension: "unknown",
            type: "Cluster"
        ),
        Location(
            id: 3,
            name: "Citadel of Ricks",
            dimension: "unknown",
            type: "Space station"
        ),
        Location(
            id: 4,
            name: "Worldender's lair",
            dimension: "unknown",
            type: "Planet"
        ),
    ]
    let episodes = [
        Episode(
            id: 1,
            name: "Pilot",
            airDate: "December 2, 2013",
            episode: "S01E01"
        ),
        Episode(
            id: 2,
            name: "Lawnmower Dog",
            airDate: "December 9, 2013",
            episode: "S01E02"
        ),
        Episode(
            id: 3,
            name: "Anatomy Park",
            airDate: "December 16, 2013",
            episode: "S01E03"
        ),
        Episode(
            id: 4,
            name: "M. Night Shaym-Aliens!",
            airDate: "January 13, 2014",
            episode: "S01E04"
        ),
    ]
}
#endif
