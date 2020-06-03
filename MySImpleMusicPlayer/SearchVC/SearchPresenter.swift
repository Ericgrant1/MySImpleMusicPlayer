//
//  SearchPresenter.swift
//  MySImpleMusicPlayer
//
//  Created by Eric Grant on 03.06.2020.
//  Copyright (c) 2020 Eric Grant. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
    func presentData(response: Search.Model.Response.ResponseType)
}

class SearchPresenter: SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?
    
    func presentData(response: Search.Model.Response.ResponseType) {
        
        switch response {
            
        case .some:
            print("DEBUG: presenter .some")
        case .presentTracks:
            print("DEBUG: presenter .presentTracks")
            viewController?.displayData(viewModel: Search.Model.ViewModel.ViewModelData.displayTracks)
        }
    }
    
}
