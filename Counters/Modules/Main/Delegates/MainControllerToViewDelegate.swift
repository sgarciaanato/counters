//
//  MainControllerToViewDelegate.swift
//  Counters
//
//  Created by Samuel García on 28-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

protocol MainControllerToViewDelegate {
    func configureEditingLayout()
    func goToCreateItem()
    func hideLoading()
    func openShareViewController(objectsToShare : [Any])
    func setDataSource(_ dataSource : UITableViewDataSource)
    func setDescriptionCounterText(_ text: String)
    func showActionSheet(title: String?, message: String?, actions : [String:(()->())])
    func showDialogError(title: String, message: String, actions : [String:(()->())])
    func showError(error : ErrorModel)
    func showLoading()
    func showNoResults()
    func showTableView()
    func showWelcomeScreen()
}

extension MainView : MainControllerToViewDelegate {
    func goToCreateItem() {
        performSegue(withIdentifier: "createItemSegue", sender: nil)
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
        
        self.present(activityViewController, animated: true) {
            self.hideLoading()
        }
    }
    
    func setDataSource(_ dataSource : UITableViewDataSource) {
        self.countersTableView.dataSource = dataSource
    }
    
    func setDescriptionCounterText(_ text: String) {
        DispatchQueue.main.async {
            self.itemsCounterDescription.text = text
        }
    }
    
    func showActionSheet(title: String?, message: String?, actions : [String:(()->())]){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)

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
    
    func showError(error : ErrorModel) {
        customErrorView.configure(error: error)
        DispatchQueue.main.async {
            self.countersTableView.isHidden = true
            self.customErrorView.isHidden = false
            self.noResultsLabel.isHidden = true
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.countersTableView.activityIndicator(loading: true)
        }
    }
    
    func showNoResults(){
        DispatchQueue.main.async {
            self.countersTableView.isHidden = true
            self.customErrorView.isHidden = true
            self.noResultsLabel.isHidden = false
        }
    }
    
    func showTableView(){
        DispatchQueue.main.async {
            self.countersTableView.isHidden = false
            self.customErrorView.isHidden = true
            self.noResultsLabel.isHidden = true
            self.countersTableView.reloadData()
        }
    }
    
    func showWelcomeScreen () {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showWelcomeScreen", sender: nil)
        }
    }
    
}
