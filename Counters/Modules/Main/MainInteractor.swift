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
    
    var counters : [Counter] = []
    
    init() {
        fetchCounters()
    }
    
    func fetchCounters() {
        NetworkOperation.shared.request(paths: [.api, .v1, .counters]) { (result : Result<[Counter]?,Error>) in
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
                let errorModel = ErrorModel(title: "Couldn't load the counters", description: error.localizedDescription, buttonTitle: "Retry") {
                    self.fetchCounters()
                }
                self.controller?.showError(error: errorModel)
                
            }
        }
    }
    
    func increment(_ counter : Counter) {
        guard let index = counters.firstIndex(where: { $0.id == counter.id }) else { return }
        counters[index].count += 1
        controller?.reloadData()
        updateCounterDescriptionText()
    }
    
    func decrement(_ counter : Counter) {
        guard let index = counters.firstIndex(where: { $0.id == counter.id }) else { return }
        counters[index].count -= 1
        controller?.reloadData()
        updateCounterDescriptionText()
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
    }
    
}

protocol MainInteractorToControllerDelegate {
    func reloadData()
    func setDescriptionCounterText(_ text: String)
    func showError(error : ErrorModel)
    func goToCreateItem()
}
