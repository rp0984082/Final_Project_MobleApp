//
//  PokemonView.swift
//  Final Project
//
//  Created by PEREZ, ROBERTO on 4/30/25.
//

import SwiftUI

struct PokemonView: View {
    @StateObject private var viewModel = AllPokemonModel()

    var body: some View {
        NavigationStack {
            VStack {
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.pokemonList) { pokemon in
                        Text(pokemon.name.capitalized)
                    }
                }
            }
            .navigationTitle("All Pokémon")
            .onAppear {
                viewModel.fetchAllPokemon()
            }
        }
    }
}

#Preview {
    PokemonView()
}
