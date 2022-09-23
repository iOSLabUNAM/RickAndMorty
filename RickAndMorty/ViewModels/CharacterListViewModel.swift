//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 20/09/22.
//

import Foundation
import Amaca

@MainActor
class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    var currentPage = 1
    let apiClient = Amaca.Client(Api.rickAndMorty)
    lazy var endpoint: PaginatedListEndpoint<Character> = {
        return PaginatedListEndpoint<Character>(client: apiClient, route: "/api/character")
    }()

    func load() async {
        guard let response = try? await endpoint.show(page: currentPage) else { return }
        self.characters.append(contentsOf: response.results)
        self.currentPage += 1
    }

    func isLast(character: Character) -> Bool {
        if self.characters.isEmpty { return false }

        return self.characters.last == character
    }
}
