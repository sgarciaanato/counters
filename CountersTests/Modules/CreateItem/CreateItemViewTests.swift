//
//  CreateItemViewTests.swift
//  CountersTests
//
//  Created by Samuel García on 28-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import XCTest
@testable import Counters

class CreateItemViewTests: XCTestCase {

    var view : CreateItemView!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        view = storyboard.instantiateViewController(withIdentifier: "CreateItemView") as? CreateItemView
        
        view.beginAppearanceTransition(true, animated: false)
        view.endAppearanceTransition()
        
        view.viewDidLoad()
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
    }

    func test_BarButtonSet() {
        let leftBarButtonItem = view.navigationItem.leftBarButtonItem!
        let rightBarButtonItem = view.navigationItem.rightBarButtonItem!
        
        XCTAssertEqual(leftBarButtonItem.title, "Cancel")
        XCTAssertEqual(rightBarButtonItem.title, "Save")
        
        XCTAssertEqual(leftBarButtonItem.action, #selector(view.backAction(_:)))
        XCTAssertEqual(rightBarButtonItem.action, #selector(view.saveAction(_:)))
    }
    
    func test_SetSelectedTitle() {
        let evalText = "Custom testing text"
        view.setSelectedTitle(evalText)
        
        XCTAssertEqual(view.titleTextfield.text, evalText)
    }

}
