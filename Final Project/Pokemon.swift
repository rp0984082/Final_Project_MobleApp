//
//  Pokemon.swift
//  Final Project
//
//  Created by PEREZ, ROBERTO on 4/28/25.
//

import Foundation


struct Pokemon: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let base_experience: Int
    let sprites: Sprites
    let types: [PokemonTypeEntry]
    let abilities: [AbilityEntry]
}

struct Sprites: Decodable {
    let front_default: String
}

struct PokemonTypeEntry: Decodable {
    let type: PokemonType
}

struct PokemonType: Decodable {
    let name: String
}

struct AbilityEntry: Decodable {
    let ability: Ability
}

struct Ability: Decodable {
    let name: String
}
