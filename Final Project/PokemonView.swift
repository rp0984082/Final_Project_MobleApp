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
                        HStack {
                            if let imageURL = pokemon.imageURL {
                                AsyncImage(url: imageURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 50, height: 50)
                                }
                            }

                            Text(pokemon.name.capitalized)
                                .font(.headline)
                        }
                        .padding(.vertical, 4)
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

