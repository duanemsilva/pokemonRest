//
//  MainViewController.swift
//  PokemonREST
//
//  Created by Duane de Moura Silva on 25/07/22.
//

import UIKit
import ToolsCPB
import SVProgressHUD

final class MainViewController: UIViewController {
    
    private var mainViewModel: MainViewModel = MainViewModel()
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = mainViewModel.getViewTitle()
        self.setupTableView()
        self.setupNavigationBar()
    }
    
    //MARK: - Setup
    private func setupTableView(){
        tableView.register(UINib(nibName: PokemonCustomCell.name, bundle: nil), forCellReuseIdentifier: PokemonCustomCell.id)
        tableView.estimatedRowHeight = PokemonCustomCell.estimatedRowHeight
        tableView.keyboardDismissMode = .interactive
        
        mainViewModel.pokemons.bind { _ in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                self.tableView.isUserInteractionEnabled = true
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass")! , style: .done, target: self, action: #selector(self.searchPokemon))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gobackward")! , style: .done, target: self, action: #selector(self.reloadData))
    }
    
    //MARK: - Actions
    @objc func reloadData(){
        SVProgressHUD.show()
        self.tableView.isUserInteractionEnabled = false
        mainViewModel.getDataPokemon()
    }
    
    @objc func searchPokemon(){
        searchBar()
    }
    
    func searchBar(){
        if searchController != nil {
            self.present(searchController, animated: true, completion: nil)
            return
        }
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.keyboardType = UIKeyboardType.asciiCapable
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = mainViewModel.placeholderSearchBar
        searchController.searchResultsUpdater = self
        searchController.searchBar.barTintColor = mainViewModel.barTintColorSearchBar
        searchController.searchBar.tintColor = mainViewModel.tintColorSearchBar
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = mainViewModel.textColorSearchBar
        }
        searchController.obscuresBackgroundDuringPresentation = false
        
        self.definesPresentationContext = true
        self.present(searchController, animated: true, completion: nil)
    }
}


//MARK: - TableView DataSource
extension MainViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return mainViewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCustomCell.id, for: indexPath) as? PokemonCustomCell else { return UITableViewCell() }
        cell.setup(pokemonInfo: mainViewModel.getPokemon(with: indexPath.section)! ,viewModel: mainViewModel)
        return cell
    }
}


//MARK: - TableView Delegate
extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainViewModel.getPokemonDetail(self, url: pokemonURL.pokemon.getValue( mainViewModel.getPokemonName(id: indexPath.section) ))
    }
}


//MARK: - Search Results Updating
extension MainViewController: UISearchBarDelegate, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        mainViewModel.searchPokemon(text: searchController.searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        mainViewModel.cancelSearchPokemon()
    }
}
