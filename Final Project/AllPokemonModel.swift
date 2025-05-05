//
//  AllPokemonModel.swift
//  Final Project
//
//  Created by PEREZ, ROBERTO on 5/5/25.
//

import Foundation

class AllPokemonModel: ObservableObject {
    @Published var pokemonList: [PokemonItem] = []
    @Published var errorMessage: String?

    func fetchAllPokemon() {
        errorMessage = nil

        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else {
            errorMessage = "Invalid URL"
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    self.errorMessage = "No data received"
                    return
                }

                do {
                    let decodedResponse = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                    self.pokemonList = decodedResponse.results
                } catch {
                    self.errorMessage = "Decoding error: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

struct PokemonListResponse: Codable {
    let results: [PokemonItem]
}

struct PokemonItem: Codable, Identifiable {
    let name: String
    let url: String
    var id: String { name }
}
