//
//  PokemonManager.swift
//  PokemonREST
//
//  Created by Duane de Moura Silva on 25/07/22.
//

import Foundation
import ToolsCPB

class PokemonManager{

    public static func getPokemonData(completion: @escaping ( Result<PokemonsList, Error>) -> Void) {
        Request.shared.request(PokemonsList.self, path: pokemonURL.pokemonList.getValue(nil)) { result in
            switch result {
            case let .success(pokemons):
                completion(.success(pokemons))
                return
            case .failure:
                completion(.failure(APIErrors.requestFailed))
                return
            }
        }
    }
    
    public static func getPokemonDetail(url: String, completion: @escaping ( Result<Pokemon, Error>) -> Void){
        Request.shared.request(Pokemon.self, path: url) { result in
            switch result {
            case let .success(pokemon):
                completion(.success(pokemon))
                return
            case .failure:
                completion(.failure(APIErrors.requestFailed))
                return
            }
        }
    }
}
