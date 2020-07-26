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
        self.controller = ExamplesController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

}

extension ExamplesView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller?.getCategoryCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell {
            cell.configure(controller?.getCategory(for: indexPath.row))
            return cell
        }
        return UITableViewCell()
    }
    
    
}
