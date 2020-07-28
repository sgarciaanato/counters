//
//  CreateItemInteractor.swift
//  Counters
//
//  Created by Samuel García on 26-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import Foundation

class CreateItemInteractor {
    
    var controller : CreateItemInteractorToControllerDelegate
    
    var counters: [Counter] = []
    
    init(controller : CreateItemInteractorToControllerDelegate) {
        self.controller = controller
    }
    
    func createItem(_ title: String?) {
        
        guard let title = title else { return }
        
        self.controller.showTextFieldLoading()
        
        NetworkOperation.shared.request(paths: [.api, .v1, .counter], httpMethod: "POST",httpBody: [ "title" : title]) { (result : Result<[Counter]?,Error>) in
            
            switch result {
                case .success(let counters):
                    guard let counters = counters, counters.count > 0 else { return }
                    self.counters = counters
                    self.controller.updateCountersList()
                case .failure(_):
                    self.controller.showDialogError(title: "Couldn't create the counter counter", message: "The internet connection appears to be ofline", actions: [
                        "Dismiss" : { }
                    ])
                    debugPrint("Error")
            }
            
            self.controller.hideTextFieldLoading()
        }
    }
    
    func getCounterList() -> [Counter] {
        return self.counters
    }
    
}
