//
//  MainInteractorTests.swift
//  CountersTests
//
//  Created by Samuel García on 29-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import XCTest
@testable import Counters

class MainInteractorTests: XCTestCase {
    
    var view : MainView!
    var controller : MainController!
    var interactor : MainInteractor!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        view = storyboard.instantiateViewController(withIdentifier: "MainView") as? MainView
        
        view.beginAppearanceTransition(true, animated: false)
        view.endAppearanceTransition()
        
        controller = MainController(view: view)
        interactor = MainInteractor(controller: controller)
        controller.interactor = interactor
        
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        controller = nil
        interactor = nil
    }
    
    func test_IsSelected() {
        let selectedCounter = Counter(id: "1", title: "title", count: 0)
        let notSelectedCounter = Counter(id: "2", title: "title", count: 0)
        interactor.countersWithoutTreating = [selectedCounter,notSelectedCounter]
        interactor.selectedCounters = [selectedCounter]
        
        XCTAssertTrue(interactor.isSelected(selectedCounter))
        XCTAssertFalse(interactor.isSelected(notSelectedCounter))
        
        
    }
    
}
