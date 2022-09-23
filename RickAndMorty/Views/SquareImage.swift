//
//  SquareImage.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 21/09/22.
//

import SwiftUI

struct SquareImage: View {
    let image: Image
    let size: CGFloat
    let contentMode: ContentMode
    
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: contentMode)
            .frame(width: size, height: size)
            .clipped()
    }
}

struct SquareImage_Previews: PreviewProvider {
    static var previews: some View {
        SquareImage(
            image: Image(systemName: "xmark.icloud"),
            size: 120,
            contentMode: .fit
        )
    }
}
