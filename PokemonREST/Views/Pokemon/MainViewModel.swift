//
//  MainViewModel.swift
//  PokemonREST
//
//  Created by Duane de Moura Silva on 25/07/22.
//

import Foundation
import UIKit
import SVProgressHUD
import ToolsCPB

final class MainViewModel {
    
    static let storyboardName = "MainViewController"
    var pokemons: Observable<PokemonsList?> = Observable(nil)
    private var pokemonsBackup: PokemonsList?
    let placeholderSearchBar = "Find a pokemon"
    let barTintColorSearchBar: UIColor = #colorLiteral(red: 0.2509999871, green: 0.2509999871, blue: 0.2509999871, alpha: 1)
    let tintColorSearchBar: UIColor = .white
    let textColorSearchBar: UIColor = .white
    
    init(){
        self.getDataPokemon()
    }
    
    func getTitle()-> String {"Pokemons"}
    
    func getViewTitle()-> UIView {
        let logo = UIImage(named: "pokemon-logo-pequeno")
        return UIImageView(image:logo)
    }
    
    func getDataPokemon(){
        PokemonManager.getPokemonData { result in
            switch result {
            case let .success(pokemons):
                self.pokemons.value = pokemons
                self.pokemonsBackup = pokemons
                return
            case .failure:
                self.pokemons.value = nil
                self.pokemonsBackup = nil
                return
            }
        }
    }
    
    func getURLImage(name: String)->URL{
        let index = pokemonsBackup!.results.firstIndex(where: { pi in
            pi.name == name
        })
        
        let url = URL(string: pokemonURL.pokemonImage.getValue((index! + 1).description))
        
        return url!
    }
    
    func getPokemonName(id: Int)-> String{
        guard pokemons.value != nil else {return ""}
        return pokemons.value!.results[id].name
    }
    
    func numberOfRows()-> Int{ 1 }
    
    func numberOfSections()-> Int { self.pokemons.value?.results.count ?? 0 }
    
    func getPokemon(with id: Int)-> PokemonInfo?{
        guard pokemons.value != nil else {return nil}
        guard id < pokemons.value!.results.count  else {return nil}
        return pokemons.value!.results[id]
    }
    
    func searchPokemon(text: String?){
        
        guard text != nil else {return}
        guard !text!.isEmpty else {return}
        guard pokemonsBackup != nil else {return}
        
        pokemons.value!.results = pokemonsBackup!.results.filter {
            $0.name.localizedCaseInsensitiveContains(text!) ||
            $0.name.lowercased().folding(options: .diacriticInsensitive, locale: .current).contains(text!.lowercased())
        }
    }
    
    func cancelSearchPokemon(){
        pokemons.value!.results = pokemonsBackup!.results
    }
    
    func getPokemonDetail(_ vc: UIViewController, url: String){
        SVProgressHUD.show()
        PokemonManager.getPokemonDetail(url: url) { result in
            switch result {
            case let .success(pokemon):
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    let pokemonDetail = UIStoryboard(name: PokemonDetailViewModel.storyboardName, bundle: nil).instantiateInitialViewController() as! PokemonDetailViewController
                    pokemonDetail.modalPresentationStyle = .fullScreen
                    pokemonDetail.pokemonDetailViewModel = PokemonDetailViewModel(pk: pokemon)
                    vc.navigationController?.pushViewController(pokemonDetail, animated: true)
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    SVProgressHUD.showError(withStatus: "Erro ao obter dados do pokemon!")
                    print(error.localizedDescription)
                }
                
            }
        }
    }
}
