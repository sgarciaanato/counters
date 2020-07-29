//
//  MainViewTests.swift
//  CountersTests
//
//  Created by Samuel García on 29-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import XCTest
@testable import Counters

class MainViewTests: XCTestCase {

    var view : MainView!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        view = storyboard.instantiateViewController(withIdentifier: "MainView") as? MainView
        
        view.beginAppearanceTransition(true, animated: false)
        view.endAppearanceTransition()
        
        view.viewDidLoad()
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
    }

    func test_ViewSet() {
        let leftBarButtonItem = view.navigationItem.leftBarButtonItem!
        
        XCTAssertEqual(leftBarButtonItem.title, "Edit")
        
        XCTAssertEqual(leftBarButtonItem.action, #selector(view.edit(_:)))
        XCTAssertEqual(view.refreshControl.actions(forTarget: view, forControlEvent: .valueChanged)?.first, "refresh:")
        
        XCTAssertEqual(view.controller?.editing, false)
        XCTAssertTrue(view.deleteButton.isHidden)
        XCTAssertTrue(view.shareButton.isHidden)
        XCTAssertFalse(view.createItemButton.isHidden)
        
        XCTAssertEqual(view.itemsCounterDescription.text, "")
        
    }
    
    func test_UpdateEditingLayout() {
        view.configureEditingLayout()
        
        XCTAssertEqual(view.controller?.editing, true)
        XCTAssertFalse(view.deleteButton.isHidden)
        XCTAssertFalse(view.shareButton.isHidden)
        XCTAssertTrue(view.createItemButton.isHidden)
    }

}
