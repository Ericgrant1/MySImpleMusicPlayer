//
//  TrackCell.swift
//  MySImpleMusicPlayer
//
//  Created by Eric Grant on 04.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

protocol TrackCellViewModel {
    var iconUrlString: String? { get }
    var trackName: String { get }
    var artistName: String { get }
    var collectionName: String { get }
}

class TrackCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "TrackCell"
    
    var cell: SearchViewModel.Cell?
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var trackImageView: UIImageView!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        trackImageView.image = nil
    }
    
    // MARK: - IBActions
    
    @IBAction func addTrackAction(_ sender: Any) {
//        print("DEBUG: Add track")
        let defaults = UserDefaults.standard
//        defaults.set(25, forKey: "Age")
//        defaults.set("Hello", forKey: "String")
        
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: cell, requiringSecureCoding: false) {
            print("DEBUG: Successfully..")
            defaults.set(savedData, forKey: "tracks")
        }
    }
    
    @IBAction func showInfoAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        if let savedTrack = defaults.object(forKey: "tracks") as? Data {
            if let decodedTrack = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedTrack) as? SearchViewModel.Cell {
                print("DEBUG: Decoded trackName - \(decodedTrack.trackName)")
            }
        }
    }
    
    // MARK: - Helper functions
    
    func set(viewModel: SearchViewModel.Cell) {
        self.cell = viewModel
        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        trackImageView.sd_setImage(with: url, completed: nil)
    }
}
