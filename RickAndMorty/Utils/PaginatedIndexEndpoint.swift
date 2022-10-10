//
//  PaginatedIndexEndpoint.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 20/09/22.
//

import Foundation
import Amaca
import Combine

struct PaginatedList<T: Codable>: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
    }
    let info: Info
    let results: [T]
}

struct PaginatedListEndpoint<T> where T: Codable {
    let client: Amaca.Client
    let route: String
    let decoder: JSONDecoder = {
        var dec = JSONDecoder()
        dec.keyDecodingStrategy = .convertFromSnakeCase
        return dec
    }()

    init(client: Amaca.Client, route: String) {
        self.client = client
        self.route = route
    }

    func show(page: Int? = nil) async throws -> PaginatedList<T>? {
        let data = try await client.get(path: route, queryItems: ["page": "\(page ?? 1)"])
        guard let data = data else { return nil }

        do {
            let json = try decoder.decode(PaginatedList<T>.self, from: data)
            return json
        } catch let err {
            #if DEBUG
            debugPrint(err)
            debugPrint(String(data: data, encoding: .utf8) ?? "")
            #endif
            throw Amaca.EndpointError.invalidDecoding("Unable to decode response")
        }
    }

    func showPublisher(page: Int? = nil) -> AnyPublisher<PaginatedList<T>, Error> {
        return client
            .getPublisher(path: route, queryItems: ["page": "\(page ?? 1)"])
            .decode(type: PaginatedList<T>.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
