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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemsCounterDescription: UILabel!
    @IBOutlet weak var customErrorView: CustomErrorView!
    
    var refreshControl = UIRefreshControl()
    
    var controller : MainController?
    
    private var search = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        navigationItem.leftBarButtonItem = editButtonItem
        
        tableView.dataSource = self
        tableView.delegate = self
        
        controller = MainController(view : self)
        controller?.updateCounterDescriptionText()
        
        controller?.fetchCounters()
        showLoading()
        
        tableView.register(UINib(nibName: "CounterTableViewCell", bundle: nil), forCellReuseIdentifier: "CounterTableViewCell")

        if let split = splitViewController {
            let controllers = split.viewControllers
            createItemView = (controllers[controllers.count-1] as! UINavigationController).topViewController as? CreateItemView
        }
        
    }
    
    func configureSearchBar() {
        search.searchBar.delegate = self
        search.searchBar.sizeToFit()
        search.obscuresBackgroundDuringPresentation = false
        search.hidesNavigationBarDuringPresentation = true
        self.definesPresentationContext = true
        search.searchBar.placeholder = "Search"
        self.navigationItem.searchController = search
        
        self.navigationController?.navigationBar.addShadow()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.clipsToBounds = false
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        configureSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.clipsToBounds = true
    }
    
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue) {
        self.tableView.reloadData()
    }
    
    func updateList(_ counters : [Counter]) {
        controller?.setCounters(counters)
    }
    
    @objc func refresh(_ sender: Any){
        controller?.fetchCounters()
    }

}

extension MainView : UISearchBarDelegate {
    
}

extension MainView : CounterDelegate {
    func increment(_ counter: Counter) {
        controller?.increment(counter)
    }
    func decrement(_ counter: Counter) {
        controller?.decrement(counter)
    }
}

extension MainView : MainControllerToViewDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.customErrorView.isHidden = true
        }
    }
    func setDescriptionCounterText(_ text: String) {
        DispatchQueue.main.async {
            self.itemsCounterDescription.text = text
        }
    }
    func showError(error : ErrorModel) {
        customErrorView.configure(error: error)
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            self.customErrorView.isHidden = false
        }
    }
    func goToCreateItem() {
        performSegue(withIdentifier: "createItemSegue", sender: nil)
    }
    
    func showDialogError(title: String, message: String, actions : [String:(()->())]){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let sortedActions = actions.sorted() {$0.key > $1.key}
        
        for action in sortedActions {
            let handler : ((UIAlertAction) -> Void) = {_ in
                action.value()
            }
            alert.addAction(UIAlertAction(title: action.key, style: .default, handler: handler))
        }
        
        DispatchQueue.main.async {
            alert.view.tintColor = UIColor(named: "tintColor")
            self.present(alert, animated: true)
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.tableView.activityIndicator(loading: true)
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.tableView.activityIndicator(loading: false)
            self.refreshControl.endRefreshing()
        }
    }
}

// MARK: - Table View

extension MainView : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller?.getCountersCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CounterTableViewCell", for: indexPath) as? CounterTableViewCell {
            cell.configure(controller?.getCounterFor(indexPath.row))
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            controller?.deleteCounter(at: indexPath.row)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}
