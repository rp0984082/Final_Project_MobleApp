//
//  PokemonDetailView.swift
//  Final Project
//
//  Created by PEREZ, ROBERTO on 4/30/25.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationStack {
            TabView {
                // First Tab - Pokémon Search
                PokemonSearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }

                // Second Tab - Favorites
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "star.fill")
                    }

                // Third Tab - Settings or other
                PokemonView()
                    .tabItem {
                        Label("My Pokemon", systemImage: "person.crop.rectangle.fill")
                    }
            }
            .navigationTitle("Pokémon App")
        }
    }
}

struct PokemonSearchView: View {
    @State private var pokemonInput: String = ""
    @StateObject private var viewModel = PokemonViewModel()
    @FocusState private var isFocused: Bool

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                TextField("Enter Pokémon Name or ID", text: $pokemonInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .keyboardType(.default)
                    .focused($isFocused)
                    .onSubmit {
                        fetchPokemonData()
                    }

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

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
