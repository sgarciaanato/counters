//
//  MainControllerTests.swift
//  CountersTests
//
//  Created by Samuel García on 29-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import XCTest
@testable import Counters

class MainControllerTests: XCTestCase {
    
    var view : MainView!
    var controller : MainController!
    var customInteractor : CustomMainInteractor!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        view = storyboard.instantiateViewController(withIdentifier: "MainView") as? MainView
        
        view.beginAppearanceTransition(true, animated: false)
        view.endAppearanceTransition()
        
        controller = MainController(view: view)
        customInteractor = CustomMainInteractor(controller: controller)
        controller.interactor = customInteractor
        
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        controller = nil
        customInteractor = nil
    }
    
    func test_FetchCounters_CallInteractor() {
        controller.fetchCounters()
        XCTAssertEqual(customInteractor.calledFunctionIdentifier, "FetchCounters")
    }
    
    func test_FetchCountersWithText_CallInteractor() {
        controller.fetchCounters(searchText: "Test Text")
        XCTAssertEqual(customInteractor.calledFunctionIdentifier, "FetchCountersWithText Test Text")
    }
    
    func test_ShareSelected_CallInteractor() {
        controller.shareSelected()
        XCTAssertEqual(customInteractor.calledFunctionIdentifier, "ShareSelected")
    }
    
    func test_DeleteSelected_CallInteractor() {
        controller.deleteSelected()
        XCTAssertEqual(customInteractor.calledFunctionIdentifier, "DeleteSelected")
    }
    
}

class CustomMainInteractor : MainInteractor {
    
    var calledFunctionIdentifier = ""
    
    override func fetchCounters() {
        calledFunctionIdentifier = "FetchCounters"
    }
    
    override func fetchCounters(searchText: String?) {
        calledFunctionIdentifier = "FetchCountersWithText \(searchText!)"
    }
    
    override func shareSelected() {
        calledFunctionIdentifier = "ShareSelected"
    }
    
    override func deleteSelected() {
        calledFunctionIdentifier = "DeleteSelected"
    }
}
