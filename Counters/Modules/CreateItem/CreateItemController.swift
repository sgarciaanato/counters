//
//  CreateItemController.swift
//  Counters
//
//  Created by Samuel García on 26-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import Foundation

class CreateItemController {
    
    var view : CreateItemControllerToViewDelegate
    var interactor : CreateItemInteractor?
    
    init(view: CreateItemControllerToViewDelegate) {
        self.view = view
        interactor = CreateItemInteractor(controller : self)
    }
    
    func createItem(_ title: String?) {
        interactor?.createItem(title)
    }
    
    func getCounterList() -> [Counter]{
        return interactor?.getCounterList() ?? []
    }
    
}
