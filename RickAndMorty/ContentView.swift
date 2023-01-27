//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 02/09/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var settingsStore: SettingsStore
    var body: some View {
        TabView {
            CharacterListView()
                .environmentObject(settingsStore)
                .tabItem {
                    Image(systemName: "mustache")
                    Text("Characters")
                }
                .tag(1)
            EpisodeListView()
                .tabItem {
                    Image(systemName: "film")
                    Text("Episodes")
                }
                .tag(2)
            LocationListView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Locations")
                }
                .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SettingsStore())
    }
}
