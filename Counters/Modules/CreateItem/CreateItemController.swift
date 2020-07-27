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

extension CreateItemController : CreateItemInteractorToControllerDelegate {
    func updateCountersList() {
        view.updateCountersList()
        view.hideTextFieldLoading()
    }
    
    func showTextFieldLoading() {
        view.showTextFieldLoading()
    }
    
    func hideTextFieldLoading() {
        view.hideTextFieldLoading()
    }
    
    func showDialogError(title: String, message: String, actions: [String:(()->())]) {
        view.showDialogError(title: title, message: message, actions: actions)
    }
    
}

protocol CreateItemControllerToViewDelegate {
    func updateCountersList()
    func showTextFieldLoading()
    func hideTextFieldLoading()
    func showDialogError(title: String, message: String, actions : [String:(()->())])
}

