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
    
    var editing : Bool {
        set {
            interactor?.editing = newValue
        }
        get {
            return interactor?.editing ?? false
        }
    }
    
    init(view : MainControllerToViewDelegate) {
        self.view = view
        interactor = MainInteractor(controller : self)
        if interactor?.isFirstLoad() ?? false {
            view.showWelcomeScreen()
        }
    }
    
    func fetchCounters(searchText: String?) {
        interactor?.fetchCounters(searchText: searchText)
    }
    
    func fetchCounters() {
        interactor?.fetchCounters()
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
    
    func select(_ counter : Counter) {
        interactor?.select(counter)
    }
    
    func deselect(_ counter : Counter) {
        interactor?.deselect(counter)
    }
    
    func updateCounterDescriptionText() {
        interactor?.updateCounterDescriptionText()
    }
    
    func setCounters(_ counters : [Counter]) {
        interactor?.setCounters(counters)
    }
    
    func deleteCounter(_ counter : Counter) {
        interactor?.deleteCounter(counter)
    }
    
    func shareSelected(){
        interactor?.shareSelected()
    }
    
    func deleteSelected() {
        interactor?.deleteSelected()
    }
    
    func selectedCounterCount() -> Int {
        return interactor?.selectedCounterCount() ?? 0
    }
    
    func isSelected(_ counter : Counter?) -> Bool {
        return interactor?.isSelected(counter) ?? false
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
    func showNoResults() {
        view.showNoResults()
    }
    func hideNoResults() {
        view.hideNoResults()
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
    func updateEditingLayout() {
        view.updateEditingLayout()
    }
    func openShareViewController(objectsToShare : [Any]){
        view.openShareViewController(objectsToShare: objectsToShare)
    }
}

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
    func updateEditingLayout()
    func openShareViewController(objectsToShare : [Any])
    func showWelcomeScreen ()
}
