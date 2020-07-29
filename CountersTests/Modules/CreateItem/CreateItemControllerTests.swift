//
//  CreateItemControllerTests.swift
//  CountersTests
//
//  Created by Samuel García on 29-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import XCTest
@testable import Counters

class CreateItemControllerTests: XCTestCase {
    
    var view : CreateItemView!
    var controller : CreateItemController!
    var customInteractor : CustomCreateItemInteractor!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        view = storyboard.instantiateViewController(withIdentifier: "CreateItemView") as? CreateItemView
        
        view.beginAppearanceTransition(true, animated: false)
        view.endAppearanceTransition()
        
        controller = CreateItemController(view: view)
        customInteractor = CustomCreateItemInteractor(controller: controller)
        controller.interactor = customInteractor
        
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        controller = nil
        customInteractor = nil
    }
    
    func test_CreateItem_CallInteractor() {
        controller.createItem("Test Title")
        XCTAssertEqual(customInteractor.calledFunctionIdentifier, "CreateItem Test Title")
    }
    
    func test_GetCounterList_CallInteractor() {
        let counters = controller.getCounterList()
        XCTAssertEqual(counters.count, 0)
        XCTAssertEqual(customInteractor.calledFunctionIdentifier, "GetCounterList")
    }
    
}

class CustomCreateItemInteractor : CreateItemInteractor {
    
    var calledFunctionIdentifier = ""
    
    override func createItem(_ title: String?) {
        calledFunctionIdentifier = "CreateItem \(title!)"
    }
    
    override func getCounterList() -> [Counter]{
        calledFunctionIdentifier = "GetCounterList"
        return []
    }
    
}
