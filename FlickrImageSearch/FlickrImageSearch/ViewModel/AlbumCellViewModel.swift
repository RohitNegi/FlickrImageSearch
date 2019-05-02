//
//  AlbumCellViewModel.swift
//  FlickrImageSearchDemo
//
//  Created by Rohit Negi on 4/30/19.
//  Copyright © 2019 Rohit. All rights reserved.
//

import Foundation

struct AlbumCellViewModel{
    
    var url : URL?
    var title : String
    
    init(albumModel : AlbumModel) {
        url = albumModel.imageURL
        title = albumModel.title
    }
}
