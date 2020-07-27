//
//  MainController.swift
//  Counters
//
//  Created by Samuel García on 26-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import Foundation

class MainController {
    
    let view : MainControllerToViewDelegate
    var interactor : MainInteractor?
    
    init(view : MainControllerToViewDelegate) {
        self.view = view
        interactor = MainInteractor(controller : self)
    }
    
    func fetchCounters(searchText: String?) {
        interactor?.fetchCounters(searchText: searchText)
    }
    
    func getCountersCount() -> Int {
        return interactor?.getCountersCount() ?? 0
    }
    
    func getCounterFor(_ row : Int) -> Counter? {
        return interactor?.getCounterFor(row)
    }
    
    func increment(_ counter : Counter) {
        interactor?.increment(counter)
    }
    
    func decrement(_ counter : Counter) {
        interactor?.decrement(counter)
    }
    
    func updateCounterDescriptionText() {
        interactor?.updateCounterDescriptionText()
    }
    
    func setCounters(_ counters : [Counter]) {
        interactor?.setCounters(counters)
    }
    
    func deleteCounter(at row: Int) {
        interactor?.deleteCounter(at: row)
    }
    
}

extension MainController : MainInteractorToControllerDelegate {
    
    func showDialogError(title: String, message: String, actions: [String:(()->())]) {
        view.showDialogError(title: title, message: message, actions: actions)
    }
    
    func reloadData() {
        view.reloadData()
    }
    func setDescriptionCounterText(_ text: String) {
        view.setDescriptionCounterText(text)
    }
    func showError(error : ErrorModel) {
        view.showError(error: error)
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
}

protocol MainControllerToViewDelegate {
    func reloadData()
    func setDescriptionCounterText(_ text: String)
    func showError(error : ErrorModel)
    func goToCreateItem()
    func showDialogError(title: String, message: String, actions : [String:(()->())])
    func showLoading()
    func hideLoading()
}
