//
//  MainInteractor.swift
//  Counters
//
//  Created by Samuel García on 26-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import Foundation

class MainInteractor : NSObject {
    
    let controller : MainInteractorToControllerDelegate
    
    var searchText : String? = nil
    
    var editing : Bool = false
    
    var counters : [Counter] {
        get {
            //Loading counters search list
            if let searchText = self.searchText, searchText != "" {
                let treatedCounters = self.countersWithoutTreating.filter{ ($0.title?.lowercased().contains(searchText.lowercased()) ?? false) }
                if treatedCounters.count == 0 {
                    showNoResults()
                }else{
                    showTableView()
                }
                updateCounterDescriptionText(counters: treatedCounters)
                return treatedCounters.reversed()
            }
            
            //Loading full counters list
            updateCounterDescriptionText(counters: self.countersWithoutTreating)
            return self.countersWithoutTreating.reversed()
        }
    }
    
    var countersWithoutTreating : [Counter] = [] {
        didSet {
            for counter in selectedCounters {
                if let counterId = counter.id, !countersWithoutTreating.contains(where: { $0.id == counterId }) {
                    self.selectedCounters.removeAll { $0.id == counter.id }
                }
            }
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
            self.parseResult(result: result)
        }
    }
    
    //Read counters from local storage
    func fetchCounters(searchText: String? = "") {
        let counters : [Counter] = Cache.shared.getData() ?? []
        self.searchText = searchText
        parseCounters(counters)
    }
    
    func updateCounterDescriptionText(counters : [Counter]) {
        let count = counters.count
        guard count > 0 else {
            controller.setDescriptionCounterText("")
            return
        }
        let totalCount = counters.map({$0.count}).reduce(0, +)
        controller.setDescriptionCounterText("\(count) items · Counted \(totalCount) times")
    }
    
    func setCounters(_ counters : [Counter]) {
        parseCounters(counters)
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
                self.showTableView()
            }
        }
    }
    
    func parseResult(result : Result<[Counter]?,Error>, customFailureBlock : (()->())? = nil){
        controller.hideLoading()
        switch result {
            case .success(let counters):
            handleSuccessLoadingCounters(counters ?? [])
        case .failure(_):
            handlerErrorLoadingCounters(customFailureBlock)
        }
    }
    
    func handleSuccessLoadingCounters(_ counters : [Counter]) {
        parseCounters(counters)
    }
    
    func handlerErrorLoadingCounters(_ customFailureBlock : (()->())? = nil) {
        if let counters : [Counter] = Cache.shared.getData() {
            parseCounters(counters)
            customFailureBlock?()
            return
        }
        showCouldntLoadCounters()
    }
    
    func parseCounters(_ counters: [Counter]) {
        guard counters.count > 0 else {
            (searchText != nil && searchText != "") ? showNoResults() : showNoCountersError()
            updateCounterDescriptionText(counters: [])
            return
        }
        countersWithoutTreating = counters
        showTableView()
    }
    
    func showNoCountersError() {
        let errorModel = ErrorModel(title: "No counters yet", description: "\"When I started counting my blessings, my whole life turned aroud.\"\n-Willie Nelson", buttonTitle: "Create a counter") {
            self.controller.goToCreateItem()
        }
        controller.showError(error: errorModel)
    }
    
    func showCouldntLoadCounters() {
        let errorModel = ErrorModel(title: "Couldn't load the counters", description: "The Internet connection appears to be offline.", buttonTitle: "Retry") {
            self.fetchCounters()
        }
        self.controller.showError(error: errorModel)
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
        
        guard selectedCounterCount > 0 else {
            self.controller.showDialogError(title: "Select at least 1 item", message: "", actions: [
                "Dismiss" : { }
            ])
            return
        }

        self.controller.showActionSheet(title: "Select at least 1 item", message: "", actions: [
            "Delete \(selectedCounterCount) counter" : {
                for counter in self.selectedCounters {
                    self.deleteCounter(counter)
                }
                self.controller.configureEditingLayout()
                self.showTableView()
            }
        ])
    }
    
    func isSelected(_ counter : Counter?) -> Bool {
        guard let counterId = counter?.id else { return false }
        return selectedCounters.contains { $0.id == counterId }
    }
    
    func showNoResults(){
        self.controller.showNoResults()
    }
    
    func showTableView(){
        self.controller.showTableView()
    }
}
