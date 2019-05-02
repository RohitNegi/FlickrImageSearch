//
//  Error.swift
//  FlickrImageSearchDemo
//
//  Created by Rohit Negi on 4/30/19.
//  Copyright © 2019 Rohit. All rights reserved.
//

import Foundation

struct ErrorCodes {
    static let requestInProgress   = 2002
    static let JSONParse           = 2001
    static let noNextPage          = 204
    static let noContent           = 204
    static let noNetWork           = -10000
    static let invalidData         = 20004
    static let timeOut             = NSURLErrorTimedOut
}

extension NSError {
    
    class func error(errorCode: Int) -> NSError {
        return NSError(domain: "com.rohit.error", code: errorCode, userInfo: nil)
}
}
