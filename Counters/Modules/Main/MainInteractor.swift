//
//  MainInteractor.swift
//  Counters
//
//  Created by Samuel García on 26-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

class MainInteractor : NSObject {
    
    let controller : MainInteractorToControllerDelegate
    
    var searchText : String? = nil
    
    var editing : Bool = false
    
    var counters : [Counter] {
        get {
            guard let searchText = self.searchText, searchText != "" else {
                controller.hideNoResults()
                return self.countersWithoutTreating.reversed()
            }
            let treatedCounters = self.countersWithoutTreating.filter{ ($0.title?.contains(searchText) ?? false) }
            if treatedCounters.count == 0 {
                controller.showNoResults()
            }else{
                controller.hideNoResults()
            }
            return treatedCounters.reversed()
        }
    }
    
    var countersWithoutTreating : [Counter] = [] {
        didSet {
            for counter in countersWithoutTreating {
                for (index,selectedCounter) in selectedCounters.enumerated() {
                    if counter.id == selectedCounter.id {
                        selectedCounters[index] = counter
                    }
                }
            }
        }
    }
    
    var selectedCounters : [Counter] = []
    
    init(controller : MainInteractorToControllerDelegate) {
        self.controller = controller
        super.init()
        self.controller.setDataSource(self)
    }
    
    func fetchCounters() {
        searchText = nil
        NetworkOperation.shared.request(paths: [.api, .v1, .counters], httpBody: nil) { (result : Result<[Counter]?,Error>) in
            self.parseResult(result: result) {
                let errorModel = ErrorModel(title: "Couldn't load the counters", description: "The Internet connection appears to be offline.", buttonTitle: "Retry") {
                    self.controller.showLoading()
                    self.fetchCounters()
                }
                self.controller.showError(error: errorModel)
            }
        }
    }
    
    func fetchCounters(searchText: String? = "") {
        self.searchText = searchText
        if searchText != nil, let counters : [Counter] = Cache.shared.getData() {
            countersWithoutTreating = counters
            controller.reloadData()
            updateCounterDescriptionText()
            return
        }
    }
    
    func updateCounterDescriptionText() {
        let count = counters.count
        let totalCount = counters.map({$0.count}).reduce(0, +)
        controller.setDescriptionCounterText("\(count) items · Counted \(totalCount) times")
        if count == 0 {
            controller.setDescriptionCounterText("")
            controller.showNoResults()
        }
    }
    
    func setCounters(_ counters : [Counter]) {
        self.countersWithoutTreating = counters
        updateCounterDescriptionText()
        self.controller.reloadData()
    }
    
    func deleteCounter(_ counter : Counter) {
        guard let id = counter.id, let title = counter.title else { return }
        deselect(counter)
        controller.showLoading()
        NetworkOperation.shared.request(paths: [.api, .v1, .counter], httpMethod: "DELETE",httpBody: [ "id" : id]) { (result : Result<[Counter]?,Error>) in
            self.controller.hideLoading()
            self.parseResult(result: result) {
                self.controller.showDialogError(title: "Couldn't delete the counter \(title)", message: "The internet connection appears to be ofline", actions: [
                    "Dismiss" : { }
                ])
                self.controller.reloadData()
            }
        }
    }
    
    func parseResult(result : Result<[Counter]?,Error>, customFailureBlock : (()->())? = nil){
        controller.hideLoading()
        switch result {
            case .success(let counters):
                guard let counters = counters, counters.count > 0 else {
                    self.countersWithoutTreating = []
                    let errorModel = ErrorModel(title: "No counters yet", description: "\"When I started counting my blessings, my whole life turned aroud.\"\n-Willie Nelson", buttonTitle: "Create a counter") {
                        self.controller.goToCreateItem()
                    }
                    self.controller.showError(error: errorModel)
                    updateCounterDescriptionText()
                    return
                }
                countersWithoutTreating = counters
                controller.reloadData()
        case .failure(let error):
            if let counters : [Counter] = Cache.shared.getData() {
                if counters.count > 0 {
                    customFailureBlock?()
                    countersWithoutTreating = counters
                    updateCounterDescriptionText()
                    controller.reloadData()
                    return
                }
                let errorModel = ErrorModel(title: "No counters yet", description: "\"When I started counting my blessings, my whole life turned aroud.\"\n-Willie Nelson", buttonTitle: "Create a counter") {
                    self.controller.goToCreateItem()
                }
                controller.showError(error: errorModel)
                return
            }
            let errorModel = ErrorModel(title: "Couldn't load the counters", description: error.localizedDescription, buttonTitle: "Retry") {
                self.fetchCounters()
            }
            self.controller.showError(error: errorModel)
        }
        updateCounterDescriptionText()
    }
    
    func shareSelected(){
        var objectsToShare : [Any] = []
        
        for counter in selectedCounters {
            objectsToShare.append("\(counter.count) x \(counter.title ?? "")")
        }
        
        objectsToShare.append("You can see the full list on sam-counters://share")
        
        controller.showLoading()
        controller.openShareViewController(objectsToShare: objectsToShare)
    }
    
    func deleteSelected() {
        let selectedCounterCount = selectedCounters.count
        
        guard selectedCounterCount > 0 else { return }
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let handler : ((UIAlertAction) -> Void) = {_ in
            for counter in self.selectedCounters {
                self.deleteCounter(counter)
            }
            self.controller.configureEditingLayout()
            self.controller.reloadData()
        }
        alert.addAction(UIAlertAction(title: "Delete \(selectedCounterCount) counter", style: .destructive, handler: handler))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        DispatchQueue.main.async {
            alert.view.tintColor = UIColor(named: "tintColor")
            self.controller.presentAlert(alert, animated: true)
        }
    }
    
    func selectedCounterCount() -> Int {
        return selectedCounters.count
    }
    
    func isSelected(_ counter : Counter?) -> Bool {
        guard let counterId = counter?.id else { return false }
        return selectedCounters.contains { $0.id == counterId }
    }
    
    func isFirstLoad() -> Bool{
        return Cache.shared.isFirstLoad()
    }
}
