//
//  MainInteractorToControllerDelegateTests.swift
//  CountersTests
//
//  Created by Samuel García on 29-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import XCTest
@testable import Counters

class MainInteractorToControllerDelegateTests: XCTestCase {
    
    var view : MainView!
    var customController : CustomMainController!
    var interactor : MainInteractor!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        view = storyboard.instantiateViewController(withIdentifier: "MainView") as? MainView
        
        view.beginAppearanceTransition(true, animated: false)
        view.endAppearanceTransition()
        
        customController = CustomMainController()
        interactor = MainInteractor(controller: customController)
        
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        customController = nil
        interactor = nil
    }
    
    func test_ConfigureEditingLayout_CallController() {
        customController.configureEditingLayout()
        XCTAssertEqual(customController.calledFunctionIdentifier, "ConfigureEditingLayout")
    }
    
    func test_GoToCreateItem_CallController() {
        customController.goToCreateItem()
        XCTAssertEqual(customController.calledFunctionIdentifier, "GoToCreateItem")
    }
    
    func test_HideLoading_CallController() {
        customController.hideLoading()
        XCTAssertEqual(customController.calledFunctionIdentifier, "HideLoading")
    }
    
    func test_OpenShareViewController_CallController() {
        customController.openShareViewController(objectsToShare: [])
        XCTAssertEqual(customController.calledFunctionIdentifier, "OpenShareViewController")
    }
    
    func test_SetDataSource_CallController() {
        customController.setDataSource(interactor)
        XCTAssertEqual(customController.calledFunctionIdentifier, "SetDataSource")
    }
    
    func test_SetDescriptionCounterText_CallController() {
        customController.setDescriptionCounterText("Text Test")
        XCTAssertEqual(customController.calledFunctionIdentifier, "SetDescriptionCounterText Text Test")
    }
    
    func test_ShowActionSheet_CallController() {
        customController.showActionSheet(title: "Test Title", message: "Test Message", actions: ["Test Action" : {}])
        XCTAssertEqual(customController.calledFunctionIdentifier, "ShowActionSheet Test Title Test Message Test Action")
    }
    
    func test_ShowDialogError_CallController() {
        customController.showDialogError(title: "Test Title", message: "Test Message", actions: ["Test Action" : {}])
        XCTAssertEqual(customController.calledFunctionIdentifier, "ShowDialogError Test Title Test Message Test Action")
    }
    
    func test_ShowError_CallController() {
        customController.showError(error: ErrorModel(title: "Test Title", description: "Test Description", buttonTitle: "Test Button Title", action: {}))
        XCTAssertEqual(customController.calledFunctionIdentifier, "ShowError Test Title Test Description Test Button Title")
    }
    
    func test_ShowLoading_CallController() {
        customController.showLoading()
        XCTAssertEqual(customController.calledFunctionIdentifier, "ShowLoading")
    }
    
    func test_ShowNoResults_CallController() {
        customController.showNoResults()
        XCTAssertEqual(customController.calledFunctionIdentifier, "ShowNoResults")
    }
    
    func test_ShowTableView_CallController() {
        customController.showTableView()
        XCTAssertEqual(customController.calledFunctionIdentifier, "ShowTableView")
    }
    
}

class CustomMainController : MainInteractorToControllerDelegate {
    
    var calledFunctionIdentifier = ""
    
    func configureEditingLayout() {
        calledFunctionIdentifier = "ConfigureEditingLayout"
    }
    
    func goToCreateItem() {
        calledFunctionIdentifier = "GoToCreateItem"
    }
    
    func hideLoading() {
        calledFunctionIdentifier = "HideLoading"
    }
    
    func openShareViewController(objectsToShare: [Any]) {
        calledFunctionIdentifier = "OpenShareViewController"
    }
    
    func setDataSource(_ dataSource: UITableViewDataSource) {
        calledFunctionIdentifier = "SetDataSource"
    }
    
    func setDescriptionCounterText(_ text: String) {
        calledFunctionIdentifier = "SetDescriptionCounterText \(text)"
    }
    
    func showActionSheet(title: String?, message: String?, actions: [String : (() -> ())]) {
        calledFunctionIdentifier = "ShowActionSheet \(title!) \(message!) \(actions.first!.key)"
    }
    
    func showDialogError(title: String, message: String, actions: [String : (() -> ())]) {
        calledFunctionIdentifier = "ShowDialogError \(title) \(message) \(actions.first!.key)"
    }
    
    func showError(error: ErrorModel) {
        calledFunctionIdentifier = "ShowError \(error.title) \(error.description) \(error.buttonTitle)"
    }
    
    func showLoading() {
        calledFunctionIdentifier = "ShowLoading"
    }
    
    func showNoResults() {
        calledFunctionIdentifier = "ShowNoResults"
    }
    
    func showTableView() {
        calledFunctionIdentifier = "ShowTableView"
    }
    
    
}
