//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 02/09/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView() {
            CharacterListView()
                .tabItem {
                    Image(systemName: "mustache")
                    Text("Characters")
                }
                .tag(1)
            LocationListView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Locations")
                }
                .tag(2)
            EpisodeListView()
                .tabItem {
                    Image(systemName: "film")
                    Text("Episodes")
                }
                .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
