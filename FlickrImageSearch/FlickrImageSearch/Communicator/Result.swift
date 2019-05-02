//
//  Result.swift
//  FlickrImageSearchDemo
//
//  Created by Rohit Negi on 4/30/19.
//  Copyright © 2019 Rohit. All rights reserved.
//

import Foundation

enum Result<T>{
    case success(T)
    case failure(Error?)
}

