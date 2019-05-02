//
//  Observable.swift
//  FlickrImageSearchDemo
//
//  Created by Rohit Negi on 4/30/19.
//  Copyright © 2019 Rohit. All rights reserved.
//

import Foundation

class Observer<T> {
    typealias Listener = (T) -> Void
    private var observer : Listener?
    
    func bind(_ listener: Listener?) {
        observer = listener
    }
    
    func unbind(){
        observer = nil
    }
    
    var value: T {
        didSet {
            observer?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
