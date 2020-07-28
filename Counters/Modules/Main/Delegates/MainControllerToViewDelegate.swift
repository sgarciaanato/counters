//
//  MainControllerToViewDelegate.swift
//  Counters
//
//  Created by Samuel García on 28-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

protocol MainControllerToViewDelegate {
    func reloadData()
    func setDescriptionCounterText(_ text: String)
    func showError(error : ErrorModel)
    func showNoResults()
    func hideNoResults()
    func goToCreateItem()
    func showDialogError(title: String, message: String, actions : [String:(()->())])
    func showLoading()
    func hideLoading()
    func configureEditingLayout()
    func openShareViewController(objectsToShare : [Any])
    func showWelcomeScreen()
    func setDataSource(_ dataSource : UITableViewDataSource)
    func showActionSheet(title: String, message: String, actions : [String:(()->())])
}

extension MainView : MainControllerToViewDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.countersTableView.reloadData()
            self.countersTableView.isHidden = false
            self.customErrorView.isHidden = true
        }
    }
    func setDescriptionCounterText(_ text: String) {
        DispatchQueue.main.async {
            self.itemsCounterDescription.text = text
        }
    }
    func showError(error : ErrorModel) {
        customErrorView.configure(error: error)
        DispatchQueue.main.async {
            self.countersTableView.isHidden = true
            self.customErrorView.isHidden = false
        }
    }
    func showNoResults(){
        DispatchQueue.main.async {
            self.noResultsLabel.isHidden = false
            self.countersTableView.isHidden = true
        }
    }
    func hideNoResults(){
        DispatchQueue.main.async {
            self.noResultsLabel.isHidden = true
            self.countersTableView.isHidden = false
        }
    }
    func goToCreateItem() {
        performSegue(withIdentifier: "createItemSegue", sender: nil)
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
    
    func showActionSheet(title: String, message: String, actions : [String:(()->())]){
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let sortedActions = actions.sorted() {$0.key > $1.key}
        
        for action in sortedActions {
            let handler : ((UIAlertAction) -> Void) = {_ in
                action.value()
            }
            alert.addAction(UIAlertAction(title: action.key, style: .destructive, handler: handler))
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        DispatchQueue.main.async {
            alert.view.tintColor = UIColor(named: "tintColor")
            self.present(alert, animated: true)
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.countersTableView.activityIndicator(loading: true)
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.countersTableView.activityIndicator(loading: false)
            self.refreshControl.endRefreshing()
        }
    }
    
    func openShareViewController(objectsToShare : [Any]) {
        
        let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        self.present(activityViewController, animated: true, completion: nil)
        self.hideLoading()
    }
    
    func showWelcomeScreen () {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showWelcomeScreen", sender: nil)
        }
    }
    
    func setDataSource(_ dataSource : UITableViewDataSource) {
        self.countersTableView.dataSource = dataSource
    }
    
}
