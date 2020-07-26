//
//  MainView.swift
//  Counters
//
//  Created by Samuel García on 24-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

class MainView: UIViewController {

    var createItemView: CreateItemView? = nil
    var objects = [Any]()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var itemsCounterDescription: UILabel!
    //    init() {
//        super.init(nibName: nil, bundle: nil)
//        
//        controller = DetailPresenter()
//        controller?.view = self
//        controller?.router?.view = self
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    private var search = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        search.searchBar.delegate = self
        search.searchBar.sizeToFit()
        search.obscuresBackgroundDuringPresentation = false
        search.hidesNavigationBarDuringPresentation = true
        self.definesPresentationContext = true
        search.searchBar.placeholder = "Search"
        self.navigationItem.searchController = search

        
        navigationItem.leftBarButtonItem = editButtonItem
        
        tableView.dataSource = self
        tableView.delegate = self

        if let split = splitViewController {
            let controllers = split.viewControllers
            createItemView = (controllers[controllers.count-1] as! UINavigationController).topViewController as? CreateItemView
        }
        
        tableView.register(UINib(nibName: "CounterTableViewCell", bundle: nil), forCellReuseIdentifier: "CounterTableViewCell")
        
        NetworkOperation.shared.get(endpoint: "/api/v1/counters") { (data, string) in
            
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.hidesSearchBarWhenScrolling = false
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        search.searchBar.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    @IBAction func addNewAction(_ sender: Any) {
        self.performSegue(withIdentifier: "showDetail", sender: nil)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destination as! UINavigationController).topViewController as! CreateItemView
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                createItemView = controller
            }
        }
    }

}

extension MainView : UISearchBarDelegate {
    
}

// MARK: - Table View

extension MainView : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "CounterTableViewCell", for: indexPath) as? CounterTableViewCell {
            cell.titleLabel.text = "object.description"
            return cell
        }
//        let object = objects[indexPath.row] as! NSDate
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}
