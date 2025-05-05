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
            ScrollView {
                LazyVStack(spacing: 12) {
                    if viewModel.pokemonList.isEmpty {
                        ProgressView("Loading Pokémon...")
                            .padding()
                    } else {
                        ForEach(viewModel.pokemonList) { pokemon in
                            HStack {
                                AsyncImage(url: URL(string: pokemon.sprites.front_default)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray.opacity(0.2)
                                }
                                .frame(width: 60, height: 60)

                                Text(pokemon.name.capitalized)
                                    .font(.headline)

                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.top)
            }
            .navigationTitle("All Pokémon")
            .onAppear {
                viewModel.fetchAllPokemon()
            }
        }
    }
}
