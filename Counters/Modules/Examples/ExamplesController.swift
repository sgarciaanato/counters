//
//  ExamplesController.swift
//  Counters
//
//  Created by Samuel García on 26-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import Foundation

class ExamplesController {
    
    var interactor : ExamplesInteractor?
    var view : ExamplesControllerToView
    
    init(view: ExamplesControllerToView){
        self.view = view
        interactor = ExamplesInteractor(controller : self)
    }
    
    func getSelectedTitle() -> String {
        return interactor?.getSelectedTitle() ?? ""
    }
    
}
