//
//  FlickrServiceProtocol.swift
//  FlickrImageSearchDemo
//
//  Created by Rohit Negi on 5/02/19.
//  Copyright © 2019 Rohit. All rights reserved.
//

import Foundation

protocol FlickrServiceProtocol : NSCopying {
    func fetch(searchKeyWord : String, onCompletion : CompletionHandlerWithModal<Result<[AlbumModel]>>)
}
