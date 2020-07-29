//
//  MainInteractorToControllerDelegate.swift
//  Counters
//
//  Created by Samuel García on 28-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

protocol MainInteractorToControllerDelegate {
    func setDescriptionCounterText(_ text: String)
    func showError(error : ErrorModel)
    func showNoResults()
    func showTableView()
    func goToCreateItem()
    func showDialogError(title: String, message: String, actions : [String:(()->())])
    func showLoading()
    func hideLoading()
    func configureEditingLayout()
    func openShareViewController(objectsToShare : [Any])
    func setDataSource(_ dataSource : UITableViewDataSource)
    func showActionSheet(title: String, message: String, actions : [String:(()->())])
}

extension MainController : MainInteractorToControllerDelegate {
    
    func showDialogError(title: String, message: String, actions: [String:(()->())]) {
        view.showDialogError(title: title, message: message, actions: actions)
    }
    func setDescriptionCounterText(_ text: String) {
        view.setDescriptionCounterText(text)
    }
    func showError(error : ErrorModel) {
        view.showError(error: error)
    }
    func showNoResults() {
        view.showNoResults()
    }
    func showTableView() {
        view.showTableView()
    }
    func goToCreateItem() {
        view.goToCreateItem()
    }
    
    func showLoading() {
        view.showLoading()
    }
    
    func hideLoading() {
        view.hideLoading()
    }
    func configureEditingLayout() {
        view.configureEditingLayout()
    }
    func openShareViewController(objectsToShare : [Any]){
        view.openShareViewController(objectsToShare: objectsToShare)
    }
    func setDataSource(_ dataSource : UITableViewDataSource) {
        view.setDataSource(dataSource)
    }
    func showActionSheet(title: String, message: String, actions : [String:(()->())]) {
        view.showActionSheet(title: title, message: message, actions : actions)
    }
}