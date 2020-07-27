//
//  MainInteractor.swift
//  Counters
//
//  Created by Samuel García on 26-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import Foundation

class MainInteractor {
    
    var controller : MainInteractorToControllerDelegate?
    
    var counters : [Counter] = [] {
        didSet {
            updateCounterDescriptionText()
        }
    }
    
    init() {
        fetchCounters()
    }
    
    func fetchCounters() {
        NetworkOperation.shared.request(paths: [.api, .v1, .counters], httpBody: nil) { (result : Result<[Counter]?,Error>) in
            self.parseResult(result: result)
        }
    }
    
    func increment(_ counter : Counter) {
        guard let id = counter.id, let title = counter.title else { return }
        NetworkOperation.shared.request(paths: [.api, .v1, .counter, .inc], httpMethod: "POST",httpBody: [ "id" : id]) { (result : Result<[Counter]?,Error>) in
            self.parseResult(result: result){
                self.controller?.showDialogError(title: "Couldn't update the \"\(title)\" counter to \(counter.count + 1)", message: "The internet connection appears to be ofline", actions: [
                    "Dismiss" : { },
                    "Retry" : {
                        self.increment(counter)
                    }
                ])
            }
        }
    }
    
    func decrement(_ counter : Counter) {
        guard let id = counter.id, let title = counter.title else { return }
        NetworkOperation.shared.request(paths: [.api, .v1, .counter, .dec], httpMethod: "POST",httpBody: [ "id" : id]) { (result : Result<[Counter]?,Error>) in
            self.parseResult(result: result){
                self.controller?.showDialogError(title: "Couldn't update the \"\(title)\" counter to \(counter.count - 1)", message: "The internet connection appears to be ofline", actions: [
                    "Dismiss" : { },
                    "Retry" : {
                        self.decrement(counter)
                    }
                ])
            }
        }
    }
    
    func getCountersCount() -> Int {
        return counters.count
    }
    
    func getCounterFor(_ row : Int) -> Counter {
        return counters[row]
    }
    
    func updateCounterDescriptionText() {
        let count = counters.count
        let totalCount = counters.map({$0.count}).reduce(0, +)
        controller?.setDescriptionCounterText("\(count) items · Counted \(totalCount) times")
        if count == 0 {
            controller?.setDescriptionCounterText("")
        }
    }
    
    func setCounters(_ counters : [Counter]) {
        self.counters = counters
        self.controller?.reloadData()
    }
    
    func deleteCounter(at row: Int) {
        guard let id = counters[row].id, let title = counters[row].title else { return }
        NetworkOperation.shared.request(paths: [.api, .v1, .counter], httpMethod: "DELETE",httpBody: [ "id" : id]) { (result : Result<[Counter]?,Error>) in
            self.parseResult(result: result) {
                self.controller?.showDialogError(title: "Couldn't delete the counter \(title)", message: "The internet connection appears to be ofline", actions: [
                    "Dismiss" : { }
                ])
            }
        }
    }
    
    func parseResult(result : Result<[Counter]?,Error>, customFailureBlock : (()->())? = nil){
        switch result {
            case .success(let counters):
                guard let counters = counters, counters.count > 0 else {
                    self.counters = []
                    let errorModel = ErrorModel(title: "No counters yet", description: "\"When I started counting my blessings, my whole life turned aroud.\"\n-Willie Nelson", buttonTitle: "Create a counter") {
                        self.controller?.goToCreateItem()
                    }
                    self.controller?.showError(error: errorModel)
                    return
                }
                self.counters = counters
                self.controller?.reloadData()
        case .failure(let error):
            if let counters : [Counter] = Cache.shared.getData() {
                self.counters = counters
                self.controller?.reloadData()
                customFailureBlock?()
                return
            }
            let errorModel = ErrorModel(title: "Couldn't load the counters", description: error.localizedDescription, buttonTitle: "Retry") {
                self.fetchCounters()
            }
            self.controller?.showError(error: errorModel)
        }
    }
    
}

protocol MainInteractorToControllerDelegate {
    func reloadData()
    func setDescriptionCounterText(_ text: String)
    func showError(error : ErrorModel)
    func goToCreateItem()
    func showDialogError(title: String, message: String, actions : [String:(()->())])
}
