//
//  PokemonSearchView.swift
//  Final Project
//
//  Created by PEREZ, ROBERTO on 5/5/25.
//

import SwiftUI

struct PokemonSearchView: View {
    @State private var pokemonInput: String = ""
    @StateObject private var viewModel = PokemonViewModel()
    @FocusState private var isFocused: Bool

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Search input field
                TextField("Enter Pokémon Name or ID", text: $pokemonInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .keyboardType(.default)
                    .focused($isFocused)
                    .onSubmit {
                        fetchPokemonData()
                    }

                // Search button
                Button(action: {
                    fetchPokemonData()
                }) {
                    Text("Fetch Pokémon")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(pokemonInput.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(pokemonInput.isEmpty)
                .padding(.horizontal)

                // Display Pokémon details
                if !viewModel.pokemonName.isEmpty {
                    VStack(spacing: 16) {
                        Text("Name: \(viewModel.pokemonName)")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text("ID: \(viewModel.pokemonID)")
                        Text("Height: \(viewModel.pokemonHeight) decimetres")
                        Text("Weight: \(viewModel.pokemonWeight) hectograms")
                        Text("Base Experience: \(viewModel.baseExperience)")

                        // Sprite Image
                        if let url = URL(string: viewModel.pokemonSpriteURL) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 150, height: 150)
                                case .failure:
                                    Image(systemName: "xmark.octagon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(.red)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }

                        // Pokémon Types
                        if !viewModel.pokemonTypes.isEmpty {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Types:")
                                    .font(.headline)
                                ForEach(viewModel.pokemonTypes, id: \.self) { type in
                                    Text(type)
                                }
                            }
                        }

                        // Pokémon Abilities
                        if !viewModel.pokemonAbilities.isEmpty {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Abilities:")
                                    .font(.headline)
                                ForEach(viewModel.pokemonAbilities, id: \.self) { ability in
                                    Text(ability)
                                }
                            }
                        }
                    }
                    .padding(.top)
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding(.top)
                }
            }
            .padding()
        }
        .navigationTitle("Pokémon Search")
        .onTapGesture {
            isFocused = false
        }
    }

    private func fetchPokemonData() {
        viewModel.fetchPokemon(by: pokemonInput)
    }
}

struct PokemonSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonSearchView()
    }
}
