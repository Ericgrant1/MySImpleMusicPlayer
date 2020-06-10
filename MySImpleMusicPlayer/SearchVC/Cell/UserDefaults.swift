//
//  UserDefaults.swift
//  MySImpleMusicPlayer
//
//  Created by Eric Grant on 10.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static let favoriteTrackKey = "favoriteTrackKey"
    
    func savedTracks() -> [SearchViewModel.Cell] {
        let defaults = UserDefaults.standard
        
        guard let savedTracks = defaults.object(forKey: UserDefaults.favoriteTrackKey) as? Data else { return [] }
        guard let decodedTrackes = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedTracks) as? [SearchViewModel.Cell] else { return [] }
        return decodedTrackes
    }
    
}
