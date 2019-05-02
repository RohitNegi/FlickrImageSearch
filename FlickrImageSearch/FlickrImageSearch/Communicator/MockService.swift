//
//  MockService.swift
//  FlickrImageSearchDemo
//
//  Created by Rohit Negi on 5/02/19.
//  Copyright © 2019 Rohit. All rights reserved.
//

import Foundation

class  MockSucessService: FlickrServiceProtocol {
    func copy(with zone: NSZone? = nil) -> Any {
        return MockSucessService()
    }
    
    func fetch(searchKeyWord: String, onCompletion: ((Result<[AlbumModel]>) -> Void)? = nil) {
        
         let album1  = AlbumModel(id: "B1", owner: "", secret: "C", server: "A", farm: 1, title: "title1")
         let album2  = AlbumModel(id: "B2", owner: "", secret: "C", server: "A", farm: 2, title: "title2")
         let album3  = AlbumModel(id: "B3", owner: "", secret: "C", server: "A", farm: 3, title: "title3")
        
        let albumArray = [album1,album2,album3]
        
        onCompletion?(.success(albumArray))
        
    }
    
    
}

class  MockFailureService: FlickrServiceProtocol {
    func copy(with zone: NSZone? = nil) -> Any {
        return MockFailureService()
    }
    
    func fetch(searchKeyWord: String, onCompletion: ((Result<[AlbumModel]>) -> Void)? = nil) {
        
        let error = NSError(domain: "com.rohit", code: 204, userInfo: nil)
        onCompletion?(.failure(error))
        
    }
    
    
}
