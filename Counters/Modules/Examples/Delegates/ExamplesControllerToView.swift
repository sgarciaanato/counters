//
//  ExamplesControllerToView.swift
//  Counters
//
//  Created by Samuel García on 28-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

protocol ExamplesControllerToView {
    func setDataSource(_ dataSource : UITableViewDataSource)
    func unWindToCreateItem()
}

extension ExamplesView : ExamplesControllerToView {
    
    func setDataSource(_ dataSource : UITableViewDataSource) {
        self.categoriesTableView.dataSource = dataSource
    }
    
    func unWindToCreateItem() {
        self.performSegue(withIdentifier: "unwindToCreateItem", sender: nil)
    }
    
}
