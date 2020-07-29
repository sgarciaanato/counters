//
//  MainInteractorToControllerDelegate.swift
//  Counters
//
//  Created by Samuel García on 28-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

protocol MainInteractorToControllerDelegate {
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
}

extension MainController : MainInteractorToControllerDelegate {
    
    func configureEditingLayout() {
        view.configureEditingLayout()
    }
    
    func goToCreateItem() {
        view.goToCreateItem()
    }
    
    func hideLoading() {
        view.hideLoading()
    }
    
    func openShareViewController(objectsToShare : [Any]){
        view.openShareViewController(objectsToShare: objectsToShare)
    }
    
    func setDataSource(_ dataSource : UITableViewDataSource) {
        view.setDataSource(dataSource)
    }
    
    func setDescriptionCounterText(_ text: String) {
        view.setDescriptionCounterText(text)
    }
    
    func showActionSheet(title: String?, message: String?, actions : [String:(()->())]) {
        view.showActionSheet(title: title, message: message, actions : actions)
    }
    
    func showDialogError(title: String, message: String, actions: [String:(()->())]) {
        view.showDialogError(title: title, message: message, actions: actions)
    }
    
    func showError(error : ErrorModel) {
        view.showError(error: error)
    }
    
    func showLoading() {
        view.showLoading()
    }
    
    func showNoResults() {
        view.showNoResults()
    }
    func showTableView() {
        view.showTableView()
    }
    
}
