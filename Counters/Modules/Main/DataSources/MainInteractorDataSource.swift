//
//  MainInteractorDataSource.swift
//  Counters
//
//  Created by Samuel García on 28-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

extension MainInteractor : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CounterTableViewCell", for: indexPath) as? CounterTableViewCell, indexPath.row < counters.count {
            let counter = counters[indexPath.row]
            cell.configure(counter, editing: editing, selected: isSelected(counter))
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete, indexPath.row < counters.count  {
            deleteCounter(counters[indexPath.row])
        }
    }
    
}

protocol CounterDelegate {
    func decrement(_ counter: Counter)
    func deselect(_ counter: Counter)
    func increment(_ counter: Counter)
    func select(_ counter: Counter)
}


extension MainInteractor : CounterDelegate {
    
    func decrement(_ counter: Counter) {
        guard let id = counter.id, let title = counter.title else { return }
        controller.showLoading()
        NetworkOperation.shared.request(paths: [.api, .v1, .counter, .dec], httpMethod: "POST",httpBody: [ "id" : id]) { (result : Result<[Counter]?,Error>) in
            self.controller.hideLoading()
            self.handleResult(result: result) {
                self.controller.showDialogError(title: "Couldn't update the \"\(title)\" counter to \(counter.count - 1)", message: "The internet connection appears to be ofline", actions: [
                    "Dismiss" : { },
                    "Retry" : {
                        self.decrement(counter)
                    }
                ])
            }
        }
    }
    
    func increment(_ counter: Counter) {
        guard let id = counter.id, let title = counter.title else { return }
        controller.showLoading()
        NetworkOperation.shared.request(paths: [.api, .v1, .counter, .inc], httpMethod: "POST",httpBody: [ "id" : id]) { (result : Result<[Counter]?,Error>) in
            self.controller.hideLoading()
            self.handleResult(result: result) {
                self.controller.showDialogError(title: "Couldn't update the \"\(title)\" counter to \(counter.count + 1)", message: "The internet connection appears to be ofline", actions: [
                    "Dismiss" : { },
                    "Retry" : {
                        self.increment(counter)
                    }
                ])
            }
        }
    }
    
    func deselect(_ counter: Counter) {
        self.selectedCounters.removeAll { $0.id == counter.id }
    }
    
    func select(_ counter: Counter) {
        self.selectedCounters.append(counter)
    }
    
}
