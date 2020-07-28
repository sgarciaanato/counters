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
        fetchCounters()
        showLoading()
    }
    
    func fetchCounters(searchText: String?) {
        interactor?.fetchCounters(searchText: searchText)
    }
    
    func fetchCounters() {
        interactor?.fetchCounters()
    }
    
    func updateCounterDescriptionText() {
        interactor?.updateCounterDescriptionText()
    }
    
    func setCounters(_ counters : [Counter]) {
        interactor?.setCounters(counters)
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
    
}
