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
                    self.pokemonList = []
                    return
                }

                guard let data = data else {
                    self.errorMessage = "No data received"
                    self.pokemonList = []
                    return
                }

                do {
                    let decodedResponse = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                    self.pokemonList = decodedResponse.results
                } catch {
                    self.errorMessage = "Decoding error: \(error.localizedDescription)"
                    self.pokemonList = []
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

    // Extract ID from URL to construct image URL
    var imageURL: URL? {
        guard let id = url.split(separator: "/").last(where: { !$0.isEmpty }) else { return nil }
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
    }
}
