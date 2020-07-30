//
//  CreateItemControllerToViewDelefateTests.swift
//  CountersTests
//
//  Created by Samuel García on 29-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import XCTest
@testable import Counters

class CreateItemControllerToViewDelefateTests: XCTestCase {
    
    var view : CreateItemView!
    var customView : CustomCreateItemView!
    var controller : CreateItemController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        view = storyboard.instantiateViewController(withIdentifier: "CreateItemView") as? CreateItemView
        
        view.beginAppearanceTransition(true, animated: false)
        view.endAppearanceTransition()
        
        customView = CustomCreateItemView()
        controller = CreateItemController(view: customView)
        view.controller = controller
        
        view.viewDidLoad()
        
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        customView = nil
        controller = nil
    }
    
    func test_HideTextFieldLoading_ControllerCallView() {
        controller.hideTextFieldLoading()
        XCTAssertEqual(customView.calledFunctionIdentifier, "HideTextFieldLoading")
    }
    
    func test_ShowDialogError_ControllerCallView() {
        controller.showDialogError(title: "Test Title", message: "Test Message", actions: ["Test Action" : {}])
        XCTAssertEqual(customView.calledFunctionIdentifier, "ShowDialogError Test Title Test Message Test Action")
    }
    
    func test_ShowTextFieldLoading_ControllerCallView() {
        controller.showTextFieldLoading()
        XCTAssertEqual(customView.calledFunctionIdentifier, "ShowTextFieldLoading")
    }
    
    func test_UpdateCountersList_ControllerCallView() {
        controller.updateCountersList()
        XCTAssertEqual(customView.calledFunctionIdentifier, "UpdateCountersList")
    }
    
}

class CustomCreateItemView : CreateItemControllerToViewDelegate {
    
    var calledFunctionIdentifier = ""
    
    func hideTextFieldLoading() {
        calledFunctionIdentifier = "HideTextFieldLoading"
    }
    
    func showDialogError(title: String, message: String, actions: [String : (() -> ())]) {
        calledFunctionIdentifier = "ShowDialogError \(title) \(message) \(actions.first!.key)"
    }
    
    func showTextFieldLoading() {
        calledFunctionIdentifier = "ShowTextFieldLoading"
    }
    
    func updateCountersList() {
        calledFunctionIdentifier = "UpdateCountersList"
    }
    
}
