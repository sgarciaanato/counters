//
//  MainViewSearchBarDelegate.swift
//  Counters
//
//  Created by Samuel García on 28-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

extension MainView : UISearchBarDelegate {
    
    func configureSearchBar() {
        search.searchBar.delegate = self
        search.searchBar.sizeToFit()
        search.obscuresBackgroundDuringPresentation = true
        search.hidesNavigationBarDuringPresentation = true
        self.definesPresentationContext = true
        search.searchBar.placeholder = "Search"
        self.navigationItem.searchController = search
        self.navigationController?.navigationBar.addBottomBorderWithColor(color: UIColor.hexStringToUIColor(hex: "#000000").withAlphaComponent(0.15), width: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    @objc func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        controller?.fetchCounters(searchText: searchText)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        self.view.layoutIfNeeded()
    }
    
}
