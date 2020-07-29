//
//  NetworkOperationTests.swift
//  CountersTests
//
//  Created by Samuel García on 29-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import XCTest
@testable import Counters

class NetworkOperationTests: XCTestCase {
    
    var counterId = ""
    
    func tests_runEndpointsTests() {
        
        let exp = expectation(description: "Tests all endpoints")
        
        fetchEmptyCounters() {
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 10)
        
    }
    
    func fetchEmptyCounters(completionBlock : @escaping  (()->())) {
        NetworkOperation.shared.request(paths: [.api, .v1, .counters], httpBody: nil) { (result : Result<[Counter]?,Error>) in
            switch result {
                case .success(let counters):
                    XCTAssertEqual(counters!.count, 0, "Make sure you are running a fresh server")
                    self.createCounter {
                        completionBlock()
                    }
                break
            default:
                    XCTFail("Make sure you are running the server")
            }
        }
    }
    
    func createCounter(completionBlock : @escaping  (()->())) {
        NetworkOperation.shared.request(paths: [.api, .v1, .counter], httpMethod: "POST", httpBody: [ "title" : "First Counter"]) { (result : Result<[Counter]?,Error>) in
            switch result {
                case .success(let counters):
                    XCTAssertEqual(counters!.count, 1)
                    let counter = counters!.first
                    self.counterId = counter!.id!
                    XCTAssertEqual(counter!.title!, "First Counter")
                    self.incrementCounter {
                        completionBlock()
                    }
                break
            default:
                    XCTFail("Make sure you are running the server")
            }

        }
    }
    
    func incrementCounter(completionBlock : @escaping  (()->())) {
        NetworkOperation.shared.request(paths: [.api, .v1, .counter, .inc], httpMethod: "POST",httpBody: [ "id" : counterId]) { (result : Result<[Counter]?,Error>) in
            switch result {
                case .success(let counters):
                    XCTAssertEqual(counters!.count, 1)
                    let counter = counters!.first
                    XCTAssertEqual(counter!.count, 1)
                    self.decrementCounter {
                        completionBlock()
                    }
                break
            default:
                    XCTFail("Make sure you are running the server")
            }

        }
    }
    
    func decrementCounter(completionBlock : @escaping  (()->())) {
        NetworkOperation.shared.request(paths: [.api, .v1, .counter, .dec], httpMethod: "POST",httpBody: [ "id" : counterId]) { (result : Result<[Counter]?,Error>) in
            switch result {
                case .success(let counters):
                    XCTAssertEqual(counters!.count, 1)
                    let counter = counters!.first
                    XCTAssertEqual(counter!.count, 0)
                    self.deleteCounter {
                        completionBlock()
                    }
                break
            default:
                    XCTFail("Make sure you are running the server")
            }

        }
    }
    
    func deleteCounter(completionBlock : @escaping  (()->())) {
        NetworkOperation.shared.request(paths: [.api, .v1, .counter], httpMethod: "DELETE",httpBody: [ "id" : counterId]) { (result : Result<[Counter]?,Error>) in
            switch result {
                case .success(let counters):
                    XCTAssertEqual(counters!.count, 0)
                    completionBlock()
                break
            default:
                    XCTFail("Make sure you are running the server")
            }

        }
    }
    
}
