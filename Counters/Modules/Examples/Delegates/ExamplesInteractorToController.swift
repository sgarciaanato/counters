//
//  ExamplesInteractorToController.swift
//  Counters
//
//  Created by Samuel García on 28-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

protocol ExamplesInteractorToController {
    func setDataSource(_ dataSource : UITableViewDataSource)
    func unWindToCreateItem()
}

extension ExamplesController : ExamplesInteractorToController {
    
    func setDataSource(_ dataSource : UITableViewDataSource) {
        view.setDataSource(dataSource)
    }
    
    func unWindToCreateItem() {
        view.unWindToCreateItem()
    }
    
}
