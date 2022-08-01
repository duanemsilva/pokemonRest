//
//  PokemonDetailViewController.swift
//  PokemonREST
//
//  Created by Duane de Moura Silva on 26/07/22.
//

import UIKit
import PINRemoteImage

final class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    //stats
    @IBOutlet weak var titleStats1Label: UILabel!
    @IBOutlet weak var titleStats2Label: UILabel!
    @IBOutlet weak var titleStats3Label: UILabel!
    @IBOutlet weak var titleStats4Label: UILabel!
    @IBOutlet weak var titleStats5Label: UILabel!
    @IBOutlet weak var titleStats6Label: UILabel!
    @IBOutlet weak var descriptionStats1Label: UILabel!
    @IBOutlet weak var descriptionStats2Label: UILabel!
    @IBOutlet weak var descriptionStats3Label: UILabel!
    @IBOutlet weak var descriptionStats4Label: UILabel!
    @IBOutlet weak var descriptionStats5Label: UILabel!
    @IBOutlet weak var descriptionStats6Label: UILabel!
    
    
    var pokemonDetailViewModel : PokemonDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: - Setup
    private func setupViews(){
        pokemonImageView.pin_setImage(from: pokemonDetailViewModel.getURLImage())
        nameLabel.text = pokemonDetailViewModel.getName()
        detailLabel.text = pokemonDetailViewModel.getNumberID()
        
        //secondary container
        heightLabel.text = pokemonDetailViewModel.getHeight()
        weightLabel.text = pokemonDetailViewModel.getWeight()
        abilitiesLabel.text = pokemonDetailViewModel.getAbilities()
        typeLabel.text = pokemonDetailViewModel.getTypes()
        
        //tertiary container
        titleStats1Label.text = pokemonDetailViewModel.getStats(id: 1).0
        titleStats2Label.text = pokemonDetailViewModel.getStats(id: 2).0
        titleStats3Label.text = pokemonDetailViewModel.getStats(id: 3).0
        titleStats4Label.text = pokemonDetailViewModel.getStats(id: 4).0
        titleStats5Label.text = pokemonDetailViewModel.getStats(id: 5).0
        titleStats6Label.text = pokemonDetailViewModel.getStats(id: 6).0
        
        descriptionStats1Label.text = pokemonDetailViewModel.getStats(id: 1).1
        descriptionStats2Label.text = pokemonDetailViewModel.getStats(id: 2).1
        descriptionStats3Label.text = pokemonDetailViewModel.getStats(id: 3).1
        descriptionStats4Label.text = pokemonDetailViewModel.getStats(id: 4).1
        descriptionStats5Label.text = pokemonDetailViewModel.getStats(id: 5).1
        descriptionStats6Label.text = pokemonDetailViewModel.getStats(id: 6).1
    }

    
}
