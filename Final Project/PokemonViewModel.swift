//
//  PokemonViewModel.swift
//  Final Project
//
//  Created by PEREZ, ROBERTO on 4/28/25.
//

import Foundation

class PokemonViewModel: ObservableObject {
    @Published var pokemonName: String = ""
    @Published var pokemonID: Int = 0
    @Published var pokemonTypes: [String] = []
    @Published var pokemonAbilities: [String] = []
    @Published var pokemonHeight: Int = 0
    @Published var pokemonWeight: Int = 0
    @Published var baseExperience: Int = 0
    @Published var pokemonSpriteURL: String = ""
    @Published var errorMessage: String? = nil
    
    private let baseURL = "https://pokeapi.co/api/v2/pokemon/"

    // Fetch Pokémon data from the API
    func fetchPokemon(by input: String) {
        let formattedInput = input.lowercased()

        // Guard against invalid input
        guard let url = URL(string: "\(baseURL)\(formattedInput)/") else {
            self.errorMessage = "Invalid Pokémon input."
            return
        }

        // Fetch data using URLSession
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    // Decode the JSON response
                    let decodedResponse = try JSONDecoder().decode(Pokemon.self, from: data)

                    // Update the UI on the main thread
                    DispatchQueue.main.async {
                        self.pokemonID = decodedResponse.id
                        self.pokemonName = decodedResponse.name.capitalized
                        self.pokemonHeight = decodedResponse.height
                        self.pokemonWeight = decodedResponse.weight
                        self.baseExperience = decodedResponse.base_experience
                        self.pokemonSpriteURL = decodedResponse.sprites.front_default
                        self.pokemonTypes = decodedResponse.types.map { $0.type.name.capitalized }
                        self.pokemonAbilities = decodedResponse.abilities.map { $0.ability.name.capitalized }
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            } else if let error = error {
                print("HTTP request failed: \(error)")
            }
        }.resume()
    }
}
