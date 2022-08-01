//
//  PokemonCustomCell.swift
//  PokemonREST
//
//  Created by Duane de Moura Silva on 26/07/22.
//

import UIKit
import PINRemoteImage

class PokemonCustomCell: UITableViewCell {

    static let name = "PokemonCustomCell"
    static let id = "cell"
    static let estimatedRowHeight: CGFloat = 311
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func setup(pokemonInfo : PokemonInfo, viewModel: MainViewModel ){
        nameLabel.text = pokemonInfo.name.capitalized
        pokemonImage.pin_setImage(from: viewModel.getURLImage(name: pokemonInfo.name))
    }
}
