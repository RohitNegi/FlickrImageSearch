//
//  GridViewModel.swift
//  FlickrImageSearchDemo
//
//  Created by Rohit Negi on 4/30/19.
//  Copyright © 2019 Rohit. All rights reserved.
//

import Foundation

struct GridViewModel{
    
    var albumArray : Observer<[AlbumModel]>
    
    func add(from array : [AlbumModel]){
        albumArray.value.append(contentsOf: array)
    }
    
    func clearAll(){
        albumArray.value.removeAll()
    }
    
}
