//
//  PokemonDetailViewModel.swift
//  PokemonREST
//
//  Created by Duane de Moura Silva on 26/07/22.
//

import UIKit

class PokemonDetailViewModel {
    static let storyboardName = "PokemonDetailViewController"
    let nameColor: UIColor = UIColor.hexToUIColor(hex: "#FFCB05")
    private let pokemon : Pokemon!
    
    init(pk: Pokemon){
        self.pokemon = pk
    }
    
    func getName()-> String{
        return pokemon.name.capitalized
    }
    
    func getURLImage()-> URL?{
        return URL(string: pokemonURL.pokemonImage.getValue(pokemon.id.description))
    }
    
    func getTypes()->String {
        var types: String = ""
        _ = pokemon.types.map{
            types += types.isEmpty ? $0.type.name : ", "+$0.type.name
        }
        return types.capitalized
    }
    
    func getNumberID()-> String {
        return "Nº \(pokemon.id)"
    }
    
    func getHeight()->String {
        let heightDouble: Double = Double(pokemon.height)
        return "\(heightDouble / 10) m"
    }
    
    func getWeight()->String{
        let weightDouble: Double = Double(pokemon.weight) / 10
        return "\(String(format: "%.2f", weightDouble)) kg"
    }
    
    func getAbilities()->String{
        guard pokemon.abilities.count > 0 else {return ""}
        let abilitiesNotHidden = pokemon.abilities.filter{
            !$0.isHidden
        }
        var abilities: String = ""
        _ = abilitiesNotHidden.map{
            abilities += abilities.isEmpty ? $0.ability.name : ", "+$0.ability.name
        }
        return abilities.capitalized
    }
    
    func getStats(id: Int) ->(String,String){
        guard id > 0 , id < 7 else {return ("","")}
        return (pokemon.stats[id - 1].stat.name.capitalized,pokemon.stats[id - 1].baseStat.description)
    }
}
