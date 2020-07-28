//
//  ExamplesInteractorToController.swift
//  Counters
//
//  Created by Samuel García on 28-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

protocol ExamplesInteractorToController {
    func unWindToCreateItem()
    func setDataSource(_ dataSource : UITableViewDataSource)
}

extension ExamplesController : ExamplesInteractorToController {
    func unWindToCreateItem() {
        view.unWindToCreateItem()
    }
    func setDataSource(_ dataSource : UITableViewDataSource) {
        view.setDataSource(dataSource)
    }
}
