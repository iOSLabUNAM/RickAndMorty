//
//  CachedAsyncImage.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 19/09/22.
//

import SwiftUI

struct CachedAsyncImage<Content>: View where Content: View {
    @StateObject var viewModel: CachedAsyncImageViewModel
    private let content: (AsyncImagePhase) -> Content

    init(
        url: URL?,
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        _viewModel = StateObject(wrappedValue: CachedAsyncImageViewModel(url: url))
        self.content = content
    }

    var body: some View {
        content(viewModel.phase)
    }
}

struct CachedAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        CachedAsyncImage(url: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")! ) { phase in
            switch phase {
            case .empty:
                Image("character-placeholder")
            case .success(let image):
                image
            default:
                fatalError()
            }
        }
    }
}
