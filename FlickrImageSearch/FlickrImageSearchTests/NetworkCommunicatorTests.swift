//
//  NetworkCommunicatorTests.swift
//  FlickrImageSearchDemoTests
//
//  Created by Rohit Negi on 5/01/19.
//  Copyright © 2019 Rohit. All rights reserved.
//

import Foundation

import XCTest
@testable import FlickrImageSearch

class NetworkCommunicatorTests: XCTestCase {
    let service = NetworkCommunicator()
    var flickrService = FlickrPaginatedAPIService()
    
    func test204(){
        if let url = URL(string: "https://httpstat.us/204"){
            let expectation1 = expectation(description: "vgyc")
            service.makeRequest(with: url) { (result : Result<Data>) in
                switch result{
                case .success(let data):
                    XCTAssertNil(data, "Failed 204 OK")
                case .failure(let err):
                    XCTAssertNotNil(err, "Failed 204 OK")
                }
                expectation1.fulfill()
            }
        
            waitForExpectations(timeout: 60) { (err) in
              //  XCTAssert(false)
            }
        }
    }
    
    func test404(){
        if let url = URL(string: "https://httpstat.us/404"){
            let expectation1 = expectation(description: "vgyc")
            service.makeRequest(with: url) { (result : Result<Data>) in
                switch result{
                case .success(let data):
                    XCTAssertNil(data, "Failed 404 OK")
                case .failure(let err):
                    XCTAssertNotNil(err, "Failed 404 OK")
                }
                expectation1.fulfill()
            }
            
            waitForExpectations(timeout: 60) { (err) in
                //  XCTAssert(false)
            }
        }
    }
    
    
    func test200OK(){
        if let url = URL(string: "https://httpstat.us/200"){
            let expectation1 = expectation(description: "vgyc")
            service.makeRequest(with: url) { (result : Result<Data>) in
                switch result{
                case .success(let data):
                    XCTAssertNotNil(data, "Failed 200 OK")
                case .failure(let err):
                    XCTAssertNil(err, "Failed 200 OK")
                }
                expectation1.fulfill()
            }
            
            waitForExpectations(timeout: 60) { (err) in
                //  XCTAssert(false)
            }
        }
    }
    
    func testAPI(){
        
        let expectation1 = expectation(description: "vgyc")
        flickrService.fetch(searchKeyWord: "cat") { (result : Result<[AlbumModel]>) in
            switch result{
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertTrue(response.count > 0, "Not getting data from api")
            case .failure(let err):
                XCTAssertNotNil(err,"Not working for error condition")
            }
            expectation1.fulfill()
        }
        
        waitForExpectations(timeout: 60) { (err) in
            //  XCTAssert(false)
        }
    }
    
    func testCopyAPI(){
        
        flickrService = flickrService.copy(with: nil) as! FlickrPaginatedAPIService
        let expectation1 = expectation(description: "vgyc")
        flickrService.fetch(searchKeyWord: "cat") { (result : Result<[AlbumModel]>) in
            switch result{
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertTrue(response.count > 0, "Not getting data from api")
            case .failure(let err):
                XCTAssertNotNil(err,"Not working for error condition")
            }
            expectation1.fulfill()
        }
        
        waitForExpectations(timeout: 60) { (err) in
            //  XCTAssert(false)
        }
    }
    
}
