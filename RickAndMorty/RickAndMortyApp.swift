//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 02/09/22.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    var settingsStore = SettingsStore()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(settingsStore)
        }
    }
}
