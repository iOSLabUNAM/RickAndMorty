//
//  SettingsStore.swift
//  RickAndMorty
//
//  Created by Luis Ezcurdia on 30/09/22.
//

import Foundation
import Combine

class SettingsStore: ObservableObject {
    enum CharacerFilter: String {
        case status = "view.characterListFilter.selectedStatus"
        case onlyHuman = "view.characterListFilter.onlyHuman"
    }
    init() {
        UserDefaults.standard.register(defaults: [
            CharacerFilter.status.rawValue: "All",
            CharacerFilter.onlyHuman.rawValue: false,
        ])
    }
    
    @Published
    var characterFilterSelectedStatus: String = UserDefaults.standard.string(forKey: CharacerFilter.status.rawValue) ?? "All" {
        didSet {
            UserDefaults.standard.set(characterFilterSelectedStatus, forKey: CharacerFilter.status.rawValue)
        }
    }
    
    @Published
    var characterFilterOnlyHuman: Bool = UserDefaults.standard.bool(forKey: CharacerFilter.onlyHuman.rawValue) {
        didSet {
            UserDefaults.standard.set(characterFilterOnlyHuman, forKey: CharacerFilter.onlyHuman.rawValue)
        }
    }

}
