//
//  SearchViewController.swift
//  MySImpleMusicPlayer
//
//  Created by Eric Grant on 01.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

struct TrackModel {
    var trackName: String
    var artistName: String
}

private let reuseIdentifier = "SearchCell"

class SearchViewController: UITableViewController {
    
    // MARK: - Properties
        
    private var timer: Timer?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var arrayTracks = [Track]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupSearchBar()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - Helper Functions
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    // MARK: - UITableViewDelegate/DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let track = arrayTracks[indexPath.row]
        cell.textLabel?.text = "\(track.trackName)\n\(track.artistName)"
        cell.textLabel?.numberOfLines = 2
        cell.imageView?.image = #imageLiteral(resourceName: "ely_mountain")
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // print("DEBUG: \(searchText)")
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            let url = "https://itunes.apple.com/search?term=\(searchText)"
            let params = [
                "term": "\(searchText)",
                "limit": "25"
            ]
            
            AF.request(url, method: .get, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: nil).responseData { (dataResponse) in
                if let error = dataResponse.error {
                    print("Error received requesting data: \(error.localizedDescription)")
                    return
                }
                
                guard let data = dataResponse.data else { return }
                
                let decoder = JSONDecoder()
                do {
                    let objects = try decoder.decode(SearchResponse.self, from: data)
                    print("objects: ", objects)
                    self.arrayTracks = objects.results
                    self.tableView.reloadData()
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
//                let someString = String(data: data, encoding: .utf8)
//                print(someString ?? "")
            }
        })
    }
}
