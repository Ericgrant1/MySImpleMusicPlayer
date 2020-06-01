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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        let searchVC = SearchViewController()
        let navigationVC = UINavigationController(rootViewController: searchVC)
        
        let libraryVC = ViewController()
        
        viewControllers = [
            navigationVC,
            libraryVC
        ]
    }
}
