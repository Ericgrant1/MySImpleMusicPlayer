//
//  MainTabBarController.swift
//  MySImpleMusicPlayer
//
//  Created by Eric Grant on 01.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tabBar.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.3764705882, alpha: 1)
        
        viewControllers = [
            generateViewController(rooviewController: SearchViewController(), image: #imageLiteral(resourceName: "ios10-apple-music-search-5nav-icon"), title: "Search"),
            generateViewController(rooviewController: ViewController(), image: #imageLiteral(resourceName: "ios10-apple-music-library-5nav-icon"), title: "Library")
        ]
    }
    
    // MARK: - Selectors
    
    // MARK: - Helper Functions
    
    func generateViewController(rooviewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rooviewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rooviewController.navigationItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        
        return navigationVC
    }
}
