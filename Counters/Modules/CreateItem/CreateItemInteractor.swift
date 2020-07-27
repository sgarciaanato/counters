//
//  CreateItemInteractor.swift
//  Counters
//
//  Created by Samuel García on 26-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import Foundation

class CreateItemInteractor {
    
    var controller : CreateItemInteractorToControllerDelegate?
    
    var counters: [Counter] = []
    
    func createItem(_ title: String?) {
        
        guard let title = title else { return }
        
        NetworkOperation.shared.request(paths: [.api, .v1, .counter], httpMethod: "POST",httpBody: [ "title" : title]) { (result : Result<[Counter]?,Error>) in
            switch result {
                case .success(let counters):
                    guard let counters = counters, counters.count > 0 else { return }
                    self.counters = counters
                    self.controller?.updateCountersList()
                case .failure(let error):
                    debugPrint("Error")
            }
        }
    }
    
    func getCounterList() -> [Counter] {
        return self.counters
    }
    
}

protocol CreateItemInteractorToControllerDelegate {
    func updateCountersList()
}
