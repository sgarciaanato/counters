//
//  ExamplesInteractor.swift
//  Counters
//
//  Created by Samuel García on 26-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import Foundation

class ExamplesInteractor : NSObject {
    
    let controller : ExamplesInteractorToController

    let examplesCategories : [ExamplesCategory]
    var selectedTitle = ""
    
    init(controller : ExamplesInteractorToController) {
        self.controller = controller
        examplesCategories = [
            ExamplesCategory(title: "DRINKS", examples: [
                Example(text: "Cups of coffe"),
                Example(text: "Cups of tea"),
                Example(text: "Glasses of water"),
                Example(text: "Some more")]),
            ExamplesCategory(title: "FOOD", examples: [
                Example(text: "Hot-dogs"),
                Example(text: "Cupcakes eater"),
                Example(text: "Chicken"),
                Example(text: "Some more")]),
            ExamplesCategory(title: "MISC", examples: [
                Example(text: "Times Sneezed"),
                Example(text: "Naps"),
                Example(text: "Day dreaming"),
                Example(text: "Some more")])]
        super.init()
        self.controller.setDataSource(self)
    }
    
    func getCategory(for row : Int) -> ExamplesCategory {
        return examplesCategories[row]
    }
    
    func getCategoryCount() -> Int {
        return examplesCategories.count
    }
    
    func getSelectedTitle() -> String {
        return selectedTitle
    }
    
    func unWindToCreateItem() {
        controller.unWindToCreateItem()
    }
    
}
