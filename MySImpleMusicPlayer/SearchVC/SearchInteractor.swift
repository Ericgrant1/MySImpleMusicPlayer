//
//  SearchInteractor.swift
//  MySImpleMusicPlayer
//
//  Created by Eric Grant on 03.06.2020.
//  Copyright (c) 2020 Eric Grant. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
    func makeRequest(request: Search.Model.Request.RequestType)
}

class SearchInteractor: SearchBusinessLogic {
    
    var presenter: SearchPresentationLogic?
    var service: SearchService?
    
    func makeRequest(request: Search.Model.Request.RequestType) {
        if service == nil {
            service = SearchService()
        }
        
        switch request {

        case .some:
            print("DEBUG: interactor .some")
            presenter?.presentData(response: Search.Model.Response.ResponseType.presentTracks)
        case .getTracks:
            print("DEBUG: interactor .getTracks")
            presenter?.presentData(response: Search.Model.Response.ResponseType.presentTracks)
        }
    }
    
}
