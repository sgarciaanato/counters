//
//  CreateItemInteractorToControllerDelegate.swift
//  Counters
//
//  Created by Samuel García on 28-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import Foundation

protocol CreateItemInteractorToControllerDelegate {
    func updateCountersList()
    func showTextFieldLoading()
    func hideTextFieldLoading()
    func showDialogError(title: String, message: String, actions : [String:(()->())])
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

