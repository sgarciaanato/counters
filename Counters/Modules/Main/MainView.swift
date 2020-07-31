//
//  MainView.swift
//  Counters
//
//  Created by Samuel García on 24-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

class MainView: UIViewController {
    
    @IBOutlet weak var countersTableView: UITableView!
    @IBOutlet weak var createItemButton: UIButton!
    @IBOutlet weak var customErrorView: CustomErrorView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var itemsCounterDescription: UILabel!
    @IBOutlet weak var noResultsLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    var controller : MainController?
    var createItemView: CreateItemView? = nil
    private var customEditButton : UIBarButtonItem?
    var refreshControl = UIRefreshControl()
    var search = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customEditButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.edit(_:)))
        navigationItem.leftBarButtonItem = customEditButton
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        countersTableView.addSubview(refreshControl)
        
        countersTableView.register(UINib(nibName: "CounterTableViewCell", bundle: nil), forCellReuseIdentifier: "CounterTableViewCell")
        
        controller = MainController(view : self)

        if let split = splitViewController {
            let controllers = split.viewControllers
            createItemView = (controllers[controllers.count-1] as! UINavigationController).topViewController as? CreateItemView
        }
        
        configureSearchBar()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        countersTableView.reloadData()
    }
    
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue) {
        self.countersTableView.reloadData()
    }
    
    @objc func refresh(_ sender: Any){
        controller?.fetchCounters()
    }
    
    func updateList(_ counters : [Counter]) {
        controller?.setCounters(counters)
    }
    
    @IBAction func deleteSelected(_ sender: Any) {
        controller?.deleteSelected()
    }
    
    @IBAction func shareSelected(_ sender: Any) {
        controller?.shareSelected()
    }
    
}

// MARK: Editing Configuration

extension MainView {
    
    func configureEditingLayout() {
        guard let editing = controller?.editing else { return }
        if editing {
            controller?.editing = false
            navigationItem.leftBarButtonItem?.title = "Edit"
            navigationItem.leftBarButtonItem?.style = .plain
        }else{
            controller?.editing = true
            navigationItem.leftBarButtonItem?.title = "Done"
            navigationItem.leftBarButtonItem?.style = .done
        }
        deleteButton.isHidden = editing
        shareButton.isHidden = editing
        createItemButton.isHidden = !editing
    }
    
    @objc func edit(_ sender: Any){
        configureEditingLayout()
        countersTableView.reloadData()
    }
    
}
