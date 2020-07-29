//
//  CreateItemInteractorToControllerDelegateTests.swift
//  CountersTests
//
//  Created by Samuel García on 29-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import XCTest
@testable import Counters

class CreateItemInteractorToControllerDelegateTests: XCTestCase {
    
    var view : CreateItemView!
    var customController : CustomCreateItemController!
    var interactor : CreateItemInteractor!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        view = storyboard.instantiateViewController(withIdentifier: "CreateItemView") as? CreateItemView
        
        view.beginAppearanceTransition(true, animated: false)
        view.endAppearanceTransition()
        
        customController = CustomCreateItemController()
        interactor = CreateItemInteractor(controller: customController)
        
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        customController = nil
        interactor = nil
    }
    
    func test_HideTextFieldLoading_CallController() {
        customController.hideTextFieldLoading()
        XCTAssertEqual(customController.calledFunctionIdentifier, "HideTextFieldLoading")
    }
    
    func test_ShowDialogError_CallController() {
        customController.showDialogError(title: "Test Title", message: "Test Message", actions: ["Test Action" : {}])
        XCTAssertEqual(customController.calledFunctionIdentifier, "ShowDialogError Test Title Test Message Test Action")
    }
    
    func test_ShowTextFieldLoading_CallController() {
        customController.showTextFieldLoading()
        XCTAssertEqual(customController.calledFunctionIdentifier, "ShowTextFieldLoading")
    }
    
    func test_UpdateCountersList_CallController() {
        customController.updateCountersList()
        XCTAssertEqual(customController.calledFunctionIdentifier, "UpdateCountersList")
    }
    
}

class CustomCreateItemController : CreateItemInteractorToControllerDelegate {
    
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
