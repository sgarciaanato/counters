//
//  MainViewSearchBardDelegate.swift
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
        search.obscuresBackgroundDuringPresentation = false
        search.hidesNavigationBarDuringPresentation = true
        self.definesPresentationContext = true
        search.searchBar.placeholder = "Search"
        self.navigationItem.searchController = search
        self.navigationController?.navigationBar.addShadow()
    }
    
    func prefersLargeTitles(_ largeTitle : Bool){
        navigationController?.navigationBar.prefersLargeTitles = largeTitle
        navigationItem.hidesSearchBarWhenScrolling = !largeTitle
        self.navigationController?.navigationBar.clipsToBounds = !largeTitle
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        controller?.fetchCounters(searchText: searchText)
    }
    
}
