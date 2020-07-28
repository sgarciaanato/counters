//
//  ExamplesControllerToView.swift
//  Counters
//
//  Created by Samuel García on 28-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

protocol ExamplesControllerToView {
    func unWindToCreateItem()
    func setDataSource(_ dataSource : UITableViewDataSource)
}

extension ExamplesView : ExamplesControllerToView {
    func unWindToCreateItem() {
        self.performSegue(withIdentifier: "unwindToCreateItem", sender: nil)
    }
    func setDataSource(_ dataSource : UITableViewDataSource) {
        self.categoriesTableView.dataSource = dataSource
    }
}
