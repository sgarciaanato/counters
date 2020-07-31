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
    var customInteractor : MainInteractor!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        view = storyboard.instantiateViewController(withIdentifier: "MainView") as? MainView
        
        view.beginAppearanceTransition(true, animated: false)
        view.endAppearanceTransition()
        
        controller = MainController(view: view)
        customInteractor = MainInteractor(controller: controller)
        controller.interactor = customInteractor
        
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        controller = nil
        customInteractor = nil
    }
    
    func test_IsSelected() {
        let selectedCounter = Counter(id: "1", title: "title", count: 0)
        let notSelectedCounter = Counter(id: "2", title: "title", count: 0)
        customInteractor.countersWithoutTreating = [selectedCounter,notSelectedCounter]
        customInteractor.selectedCounters = [selectedCounter]
        
        XCTAssertTrue(customInteractor.isSelected(selectedCounter))
        XCTAssertFalse(customInteractor.isSelected(notSelectedCounter))
    }
    
    func test_FetchCounters() {
        customInteractor.fetchCounters()
        expectAfter(3, identifier: "FetchCounters") {
            self.fetchCountersWithString()
        }
    }
    
    func fetchCountersWithString() {
        for char in "abcdefghijklmnñopqrstuvwxyz\".-,!·$%&/()=?¿*^¨Çç´`+¡'0987654321ºª|@#¢∞¬÷“”≠´‚][{}–…„" {
            
            customInteractor.fetchCounters(searchText: String(char))
            var testingCounters = customInteractor.countersWithoutTreating.filter{ ($0.title?.lowercased().contains(char.lowercased()) ?? true) }
            testingCounters = testingCounters.reversed()
            
            let searchedCounters = customInteractor.counters
            
            XCTAssertEqual(testingCounters.count, searchedCounters.count)
            
            for (index,counter) in searchedCounters.enumerated() {
                XCTAssertEqual(counter.id, testingCounters[index].id)
                XCTAssertEqual(counter.title, testingCounters[index].title)
                XCTAssertEqual(counter.count, testingCounters[index].count)
            }
            
            debugPrint(char)
        }
    }
    
    func expectAfter(_ time : Int, identifier: String, completionHandler: @escaping (()->())) {
        let exp = self.expectation(description: identifier)
        
        let dispatchQueue = DispatchQueue(label: "MainInteractorTests+\(identifier)", qos: .background)
        dispatchQueue.asyncAfter(deadline: .now() + TimeInterval(time)) {
            completionHandler()
            exp.fulfill()
        }

        waitForExpectations(timeout: TimeInterval(time + 1))
    }
    
}
