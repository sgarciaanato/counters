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
    
    @IBOutlet weak var noResultsLabel: UILabel!
    
    @IBOutlet weak var countersTableView: UITableView!
    @IBOutlet weak var itemsCounterDescription: UILabel!
    @IBOutlet weak var customErrorView: CustomErrorView!
    
    @IBOutlet weak var createItemButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var customEditButton : UIBarButtonItem?
    
    var refreshControl = UIRefreshControl()
    
    var controller : MainController?
    
    private var search = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        customEditButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.edit(_:)))
        navigationItem.leftBarButtonItem = customEditButton
        
        countersTableView.dataSource = self
        countersTableView.delegate = self
        
        controller = MainController(view : self)
        controller?.updateCounterDescriptionText()
        
        controller?.fetchCounters()
        showLoading()
        
        countersTableView.register(UINib(nibName: "CounterTableViewCell", bundle: nil), forCellReuseIdentifier: "CounterTableViewCell")

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
        countersTableView.addSubview(refreshControl)
        
        configureSearchBar()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        countersTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.clipsToBounds = true
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
    
    @IBAction func shareSelected(_ sender: Any) {
        controller?.shareSelected()
    }
    
    @IBAction func deleteSelected(_ sender: Any) {
        
        guard let selectedCounter = controller?.selectedCounterCount(), selectedCounter > 0 else { return }
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let handler : ((UIAlertAction) -> Void) = {_ in
            self.controller?.deleteSelected()
        }
        alert.addAction(UIAlertAction(title: "Delete \(selectedCounter) counter", style: .destructive, handler: handler))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        DispatchQueue.main.async {
            alert.view.tintColor = UIColor(named: "tintColor")
            self.present(alert, animated: true)
        }
    }
    
}

extension MainView : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        controller?.fetchCounters(searchText: searchText)
    }
}

extension MainView : CounterDelegate {
    func increment(_ counter: Counter) {
        controller?.increment(counter)
    }
    func decrement(_ counter: Counter) {
        controller?.decrement(counter)
    }
    func select(_ counter: Counter) {
        controller?.select(counter)
    }
    func deselect(_ counter: Counter) {
        controller?.deselect(counter)
    }
}

extension MainView : MainControllerToViewDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.countersTableView.reloadData()
            self.countersTableView.isHidden = false
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
            self.countersTableView.isHidden = true
            self.customErrorView.isHidden = false
        }
    }
    func showNoResults(){
        DispatchQueue.main.async {
            self.noResultsLabel.isHidden = false
            self.countersTableView.isHidden = true
        }
    }
    func hideNoResults(){
        DispatchQueue.main.async {
            self.noResultsLabel.isHidden = true
            self.countersTableView.isHidden = false
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
            self.countersTableView.activityIndicator(loading: true)
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.countersTableView.activityIndicator(loading: false)
            self.refreshControl.endRefreshing()
        }
    }
    
    func updateEditingLayout() {
        configureEditingLayout()
    }
    
    func openShareViewController(objectsToShare : [Any]) {
        
        let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        self.present(activityViewController, animated: true, completion: nil)
        self.hideLoading()
    }
    
    func showWelcomeScreen () {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showWelcomeScreen", sender: nil)
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
            let counter = controller?.getCounterFor(indexPath.row)
            cell.configure(counter, editing: controller?.editing ?? false, selected: controller?.isSelected(counter))
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete, let counter = controller?.getCounterFor(indexPath.row)  {
            controller?.deleteCounter(counter)
        }
    }
}
