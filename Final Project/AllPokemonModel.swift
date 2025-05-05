//
//  AllPokemonModel.swift
//  Final Project
//
//  Created by PEREZ, ROBERTO on 5/5/25.
//

import Foundation

class AllPokemonModel: ObservableObject {
    @Published var pokemonList: [PokemonSpriteItem] = []

    func fetchAllPokemon() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.pokemonList = decodedResponse.results
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            } else if let error = error {
                print("HTTP Request Failed: \(error)")
            }
        }.resume()
    }
}

struct PokemonListResponse: Codable {
    let results: [PokemonSpriteItem]
}

struct PokemonSpriteItem: Codable, Identifiable {
    let name: String
    let url: String
    var id: String { name }
}
