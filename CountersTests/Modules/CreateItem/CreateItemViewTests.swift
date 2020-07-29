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
        view = CreateItemView(nibName: "CreateItemView", bundle: nil)
        view.viewDidLoad()
    }

    func test_BarButtonSet() throws {
        let leftBarButtonItem = view.navigationItem.leftBarButtonItem
        let rightBarButtonItem = view.navigationItem.rightBarButtonItem
        
        XCTAssertEqual(leftBarButtonItem?.title, "Cancel")
        XCTAssertEqual(rightBarButtonItem?.title, "Saves")
    }

}
