//
//  MainView.swift
//  Counters
//
//  Created by Samuel García on 24-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

#warning("Order everything alphabetically")

import UIKit

class MainView: UIViewController {
    
    @IBOutlet weak var noResultsLabel: UILabel!
    @IBOutlet weak var countersTableView: UITableView!
    @IBOutlet weak var itemsCounterDescription: UILabel!
    @IBOutlet weak var customErrorView: CustomErrorView!
    @IBOutlet weak var createItemButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var refreshControl = UIRefreshControl()
    var search = UISearchController(searchResultsController: nil)
    var controller : MainController?
    var createItemView: CreateItemView? = nil
    private var customEditButton : UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customEditButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.edit(_:)))
        navigationItem.leftBarButtonItem = customEditButton
        
        countersTableView.register(UINib(nibName: "CounterTableViewCell", bundle: nil), forCellReuseIdentifier: "CounterTableViewCell")
        
        controller = MainController(view : self)

        if let split = splitViewController {
            let controllers = split.viewControllers
            createItemView = (controllers[controllers.count-1] as! UINavigationController).topViewController as? CreateItemView
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        countersTableView.addSubview(refreshControl)
        
        configureSearchBar()
        prefersLargeTitles(true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        countersTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        prefersLargeTitles(false)
    }
    
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue) {
        self.countersTableView.reloadData()
    }
    
    func updateList(_ counters : [Counter]) {
        controller?.setCounters(counters)
    }
    
    @objc func refresh(_ sender: Any){
        controller?.fetchCounters()
    }
    
    @IBAction func shareSelected(_ sender: Any) {
        controller?.shareSelected()
    }
    
    @IBAction func deleteSelected(_ sender: Any) {
        controller?.deleteSelected()
    }
    
}

// MARK: Editing Configuration

extension MainView {
    
    @objc func edit(_ sender: Any){
        configureEditingLayout()
        countersTableView.reloadData()
    }
    
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
    
}
