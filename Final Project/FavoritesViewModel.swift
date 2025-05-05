//
//  FavoritesViewModel.swift
//  Final Project
//
//  Created by PEREZ, ROBERTO on 5/5/25.
//

import Foundation
import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var favorites: [PokemonSpriteItem] = []

    func isFavorite(_ pokemon: PokemonSpriteItem) -> Bool {
        favorites.contains(where: { $0.name == pokemon.name })
    }

    func toggleFavorite(_ pokemon: PokemonSpriteItem) {
        if isFavorite(pokemon) {
            favorites.removeAll { $0.name == pokemon.name }
        } else {
            favorites.append(pokemon)
        }
    }
}
