//
//  TrackCell.swift
//  MySImpleMusicPlayer
//
//  Created by Eric Grant on 04.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation
import UIKit

class TrackCell: UITableViewCell {
    
    static let reuseIdentifier = "TrackCell"
    
    @IBOutlet weak var trackImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
