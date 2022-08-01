//
//  PokemonList.swift
//  PokemonREST
//
//  Created by Duane de Moura Silva on 26/07/22.
//


import Foundation

// MARK: - PokemonsList
struct PokemonsList: Codable {
    let count: Int
    let next, previous: JSONNull?
    var results: [PokemonInfo]
}

// MARK: - Result
struct PokemonInfo: Codable {
    let name: String
    let url: String
}
