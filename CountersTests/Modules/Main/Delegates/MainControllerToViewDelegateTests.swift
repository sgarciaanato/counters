//
//  MainControllerToViewDelegateTests.swift
//  CountersTests
//
//  Created by Samuel García on 29-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import XCTest
@testable import Counters

class MainControllerToViewDelegateTests: XCTestCase {
    
    var view : MainView!
    var customView : CustomMainView!
    var controller : MainController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        view = storyboard.instantiateViewController(withIdentifier: "MainView") as? MainView
        
        view.beginAppearanceTransition(true, animated: false)
        view.endAppearanceTransition()
        
        customView = CustomMainView()
        view.controller = MainController(view: customView)
        
        view.viewDidLoad()
        
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        customView = nil
        controller = nil
    }
    
    func test_ConfigureEditingLayout_CallController() {
        customView.configureEditingLayout()
        XCTAssertEqual(customView.calledFunctionIdentifier, "ConfigureEditingLayout")
    }
    
    func test_GoToCreateItem_CallController() {
        customView.goToCreateItem()
        XCTAssertEqual(customView.calledFunctionIdentifier, "GoToCreateItem")
    }
    
    func test_HideLoading_CallController() {
        customView.hideLoading()
        XCTAssertEqual(customView.calledFunctionIdentifier, "HideLoading")
    }
    
    func test_OpenShareViewController_CallController() {
        customView.openShareViewController(objectsToShare: [])
        XCTAssertEqual(customView.calledFunctionIdentifier, "OpenShareViewController")
    }
    
    func test_SetDataSource_CallController() {
        customView.setDataSource(MainInteractor(controller: MainController(view: customView)))
        XCTAssertEqual(customView.calledFunctionIdentifier, "SetDataSource")
    }
    
    func test_SetDescriptionCounterText_CallController() {
        customView.setDescriptionCounterText("Text Test")
        XCTAssertEqual(customView.calledFunctionIdentifier, "SetDescriptionCounterText Text Test")
    }
    
    func test_ShowActionSheet_CallController() {
        customView.showActionSheet(title: "Test Title", message: "Test Message", actions: ["Test Action" : {}])
        XCTAssertEqual(customView.calledFunctionIdentifier, "ShowActionSheet Test Title Test Message Test Action")
    }
    
    func test_ShowDialogError_CallController() {
        customView.showDialogError(title: "Test Title", message: "Test Message", actions: ["Test Action" : {}])
        XCTAssertEqual(customView.calledFunctionIdentifier, "ShowDialogError Test Title Test Message Test Action")
    }
    
    func test_ShowError_CallController() {
        customView.showError(error: ErrorModel(title: "Test Title", description: "Test Description", buttonTitle: "Test Button Title", action: {}))
        XCTAssertEqual(customView.calledFunctionIdentifier, "ShowError Test Title Test Description Test Button Title")
    }
    
    func test_ShowLoading_CallController() {
        customView.showLoading()
        XCTAssertEqual(customView.calledFunctionIdentifier, "ShowLoading")
    }
    
    func test_ShowNoResults_CallController() {
        customView.showNoResults()
        XCTAssertEqual(customView.calledFunctionIdentifier, "ShowNoResults")
    }
    
    func test_ShowTableView_CallController() {
        customView.showTableView()
        XCTAssertEqual(customView.calledFunctionIdentifier, "ShowTableView")
    }
    
}

class CustomMainView : MainControllerToViewDelegate {
    
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
    
    func showWelcomeScreen() {
        calledFunctionIdentifier = "ShowWelcomeScreen"
    }
    
}
