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
        if Cache.shared.isFirstLoad() {
            view.showWelcomeScreen()
        }
        fetchCounters()
        showLoading()
    }
    
    func fetchCounters() {
        interactor?.fetchCounters()
    }
    
    func fetchCounters(searchText: String?) {
        interactor?.fetchCounters(searchText: searchText)
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
    
}
