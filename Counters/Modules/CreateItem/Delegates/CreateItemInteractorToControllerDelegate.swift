//
//  CreateItemInteractorToControllerDelegate.swift
//  Counters
//
//  Created by Samuel García on 28-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import Foundation

protocol CreateItemInteractorToControllerDelegate {
    func hideTextFieldLoading()
    func showDialogError(title: String, message: String, actions : [String:(()->())])
    func showTextFieldLoading()
    func updateCountersList()
}

extension CreateItemController : CreateItemInteractorToControllerDelegate {
    
    func hideTextFieldLoading() {
        view.hideTextFieldLoading()
    }
    
    func showDialogError(title: String, message: String, actions: [String:(()->())]) {
        view.showDialogError(title: title, message: message, actions: actions)
    }
    
    func showTextFieldLoading() {
        view.showTextFieldLoading()
    }
    
    func updateCountersList() {
        view.updateCountersList()
        view.hideTextFieldLoading()
    }
}

