//
//  TabBarViewModel.swift
//  PokemonREST
//
//  Created by Duane de Moura Silva on 25/07/22.
//

import Foundation
import UIKit

class TabBarViewModel{
    
    let unselectedItemTintColor: UIColor = .white
    let barTintColor: UIColor = #colorLiteral(red: 0.2509999871, green: 0.2509999871, blue: 0.2509999871, alpha: 1)
    let titleTextAttributes: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor.white]
    let navBarIsTranslucent = false
    let backgroundColor: UIColor = #colorLiteral(red: 0.2509999871, green: 0.2509999871, blue: 0.2509999871, alpha: 1)
    
    
    public func getViewControllers()->[UIViewController]{
        
        let mainVC = UIStoryboard(name: MainViewModel.storyboardName, bundle: nil).instantiateInitialViewController() as! MainViewController
        let mainNVC = UINavigationController(rootViewController: mainVC)
        mainNVC.tabBarItem = UITabBarItem(title: "Pokemon", image: UIImage(named: "pokeball-mono")!.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "pokeball-color")!.withRenderingMode(.alwaysOriginal))

        return [mainNVC]
    }
}
