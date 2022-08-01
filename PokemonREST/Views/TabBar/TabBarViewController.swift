//
//  TabBarVC.swift
//  PokemonREST
//
//  Created by Duane de Moura Silva on 25/07/22.
//

import UIKit
import ToolsCPB

class TabBarViewController: UITabBarController{
    
    private let tabBarViewModel: TabBarViewModel = TabBarViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.unselectedItemTintColor = tabBarViewModel.unselectedItemTintColor
        UITabBar.appearance().barTintColor = tabBarViewModel.barTintColor
        
        UINavigationBar.appearance().backgroundColor = tabBarViewModel.backgroundColor
        UINavigationBar.appearance().barTintColor = tabBarViewModel.barTintColor
        UINavigationBar.appearance().titleTextAttributes = tabBarViewModel.titleTextAttributes
        UINavigationBar.appearance().isTranslucent = tabBarViewModel.navBarIsTranslucent
        
        setViewControllers(tabBarViewModel.getViewControllers(), animated: true)
    }
}


