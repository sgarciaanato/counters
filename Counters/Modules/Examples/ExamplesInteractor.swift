//
//  ExamplesInteractor.swift
//  Counters
//
//  Created by Samuel García on 26-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import Foundation

class ExamplesInteractor {

    let examplesCategories : [ExamplesCategory]
    var selectedTitle = ""
    
    init() {
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
    
    func setSelectedTitle (_ title : String) {
        selectedTitle = title
    }
    
}
