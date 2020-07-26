//
//  ExamplesController.swift
//  Counters
//
//  Created by Samuel García on 26-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import Foundation

class ExamplesController {
    
    var interactor : ExamplesInteractor
    
    init(){
        interactor = ExamplesInteractor()
    }
    
    func getCategory(for row : Int) -> ExamplesCategory{
        return interactor.getCategory(for : row)
    }
    
    func getCategoryCount() -> Int {
        return interactor.getCategoryCount()
    }
    
    func getSelectedTitle() -> String {
        return interactor.getSelectedTitle()
    }
    
    func setSelectedTitle (_ title : String) {
        interactor.setSelectedTitle(title)
    }
    
}
