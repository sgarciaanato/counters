//
//  ExamplesInteractorDataSource.swift
//  Counters
//
//  Created by Samuel García on 28-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

extension ExamplesInteractor : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examplesCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell, indexPath.row < examplesCategories.count {
            cell.configure(examplesCategories[indexPath.row])
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
}

protocol ExampleSelectionDelegate {
    func setSelectedTitle(_ title : String)
}

extension ExamplesInteractor : ExampleSelectionDelegate {
    func setSelectedTitle(_ title : String) {
        selectedTitle = title
        controller.unWindToCreateItem()
    }
}
