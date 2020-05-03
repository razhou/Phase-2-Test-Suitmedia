//
//  FourViewModel.swift
//  suitmedia
//
//  Created by Jelajah Data Semesta on 03/05/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation

class FourViewModel: NetworkService {
    
    private var delegate: FourViewModelDelegate?
    
    init(delegate:FourViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchApi() {
        self.delegate?.load(isLoad: true)
        
        callApi(endPoint: Api.user.rawValue) { (response) in
            switch response {
                
            case .success(_, let response):
                let res = ModelScreenFour.init(fromDictionary: response)
                self.delegate?.success(response: res.data)
                self.delegate?.load(isLoad: false)
            case .failureResponse(_, _):
                self.delegate?.error(error: .failedMappingError)
                 self.delegate?.load(isLoad: false)
            case .failureJson:
                self.delegate?.error(error: .invalidJSONError)
                 self.delegate?.load(isLoad: false)
            case .failureError(_):
                 self.delegate?.load(isLoad: false)
                 self.delegate?.error(error: .invalidJSONError)
            case .failure:
                 self.delegate?.load(isLoad: false)
                self.delegate?.error(error: .invalidJSONError)
            case .notConnectedToInternet:
                 self.delegate?.load(isLoad: false)
                self.delegate?.error(error: .connectionError)
           
            }
        }
    }
    
}


protocol FourViewModelDelegate {
    func success(response: [DataUser])
    func error(error: ApiError)
    func load(isLoad: Bool)
}
