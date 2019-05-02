//
//  FlickrImageSearchTests.swift
//  FlickrImageSearchTests
//
//  Created by Rohit Negi on 03/05/19.
//  Copyright © 2019 Rohit Negi. All rights reserved.
//

import XCTest
@testable import FlickrImageSearch

class FlickrImageSearchTests: XCTestCase {
    let observable = Observer<Int>(5)
    var numberOfTimesObservableCalled = 0
    
    var viewController : ViewController!
    
    override func setUp() {
        super.setUp()
        let navigationCntroller =  UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController() as? UINavigationController
        viewController = (navigationCntroller?.viewControllers.first as! ViewController)
        _ = viewController.view
    }
    
    func testSucess() {
        viewController.service = MockSucessService()
        viewController.fetch()
        XCTAssertTrue(viewController.gridViewModel.albumArray.value.count == 3, "Sucess condition failed")
        
    }
    
    func testFailure(){
        viewController.service = MockFailureService()
        viewController.fetch()
        XCTAssertTrue(viewController.gridViewModel.albumArray.value.count == 0, "Failure Condition not working")
    }
    
    func testPagination(){
        viewController.service = MockSucessService()
        viewController.fetch()
        viewController.fetch()
        XCTAssertTrue(viewController.gridViewModel.albumArray.value.count == 6, "Pagination failed")
    }
    
    func testrefresh(){
        viewController.service = MockSucessService()
        viewController.fetch()
        viewController.fetch()
        viewController.refresh()
        XCTAssertTrue(viewController.gridViewModel.albumArray.value.count == 3, "Refresh failed failed")
    }
    
    
    func testObservableForSameValue()  {
        
        var testNumbers = [5,6,7,8,9,10]
        
        for i in 0..<testNumbers.count{
            observable.bind { x in
                self.numberOfTimesObservableCalled += 1
                XCTAssertEqual(self.numberOfTimesObservableCalled, i+1)
            }
            
            observable.value = testNumbers[i]
            observable.unbind()
        }
    }
    
    func testAlbum() {
        let album  = AlbumModel(id: "B", owner: "", secret: "C", server: "A", farm: 1, title: "")
        XCTAssertEqual(album.imageURL?.absoluteString, "https://farm1.static.flickr.com/A/B_C.jpg")
    }
}
