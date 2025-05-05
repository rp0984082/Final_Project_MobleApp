//
//  PokemonDetailView.swift
//  Final Project
//
//  Created by PEREZ, ROBERTO on 4/30/25.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        TabView {
            // Tab 1 - Pokémon Search
            NavigationStack {
                PokemonSearchView()
            }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }

            // Tab 2 - Favorites
            NavigationStack {
                FavoritesView()
            }
            .tabItem {
                Label("Favorites", systemImage: "star.fill")
            }

            // Tab 3 - All Pokémon 
            NavigationStack {
                PokemonView()
            }
            .tabItem {
                Label("All Pokémon", systemImage: "list.bullet")
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
