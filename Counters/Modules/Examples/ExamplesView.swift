//
//  ExamplesView.swift
//  Counters
//
//  Created by Samuel García on 25-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

class ExamplesView: UIViewController {
    
    @IBOutlet weak var categoriesTableView: UITableView!
    
    var controller : ExamplesController?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        controller = ExamplesController(view : self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
    }
    
    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let createItemView = segue.destination as? CreateItemView {
            createItemView.setSelectedTitle(controller?.getSelectedTitle() ?? "")
        }
    }

}
