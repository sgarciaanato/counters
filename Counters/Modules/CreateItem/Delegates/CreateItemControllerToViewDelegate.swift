//
//  CreateItemControllerToViewDelegate.swift
//  Counters
//
//  Created by Samuel García on 28-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

protocol CreateItemControllerToViewDelegate {
    func updateCountersList()
    func showTextFieldLoading()
    func hideTextFieldLoading()
    func showDialogError(title: String, message: String, actions : [String:(()->())])
}

extension CreateItemView : CreateItemControllerToViewDelegate {
    func updateCountersList() {
        DispatchQueue.main.async {
            self.titleTextfield.text = ""
            self.titleTextfield.endEditing(false)
            self.performSegue(withIdentifier: "unwindToMain", sender: nil)
        }
    }
    
    func showTextFieldLoading() {
        DispatchQueue.main.async {
            self.saveBtn?.isEnabled = false
            self.titleTextfield.activityIndicator(loading: true)
        }
    }
    
    func hideTextFieldLoading() {
        DispatchQueue.main.async {
            self.saveBtn?.isEnabled = true
            self.titleTextfield.activityIndicator(loading: false)
        }
    }
    
    func showDialogError(title: String, message: String, actions : [String:(()->())]){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let sortedActions = actions.sorted() {$0.key > $1.key}
        
        for action in sortedActions {
            let handler : ((UIAlertAction) -> Void) = {_ in
                action.value()
            }
            alert.addAction(UIAlertAction(title: action.key, style: .default, handler: handler))
        }
        
        DispatchQueue.main.async {
            alert.view.tintColor = UIColor(named: "tintColor")
            self.present(alert, animated: true)
        }
    }
}

