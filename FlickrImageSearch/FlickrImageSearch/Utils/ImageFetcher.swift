//
//  ImageDownloader.swift
//  FlickrImageSearchDemo
//
//  Created by Rohit Negi on 4/30/19.
//  Copyright © 2019 Rohit. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

class ImageFetcher{
    
    private var task : URLSessionDataTask?
    
    func cancel(){
        task?.cancel()
    }
    
    func setImage(url : URL, imageView : UIImageView, placeHolder : UIImage? = nil) {
        
        imageView.image = placeHolder
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            imageView.image = cachedImage
            return
        }
        
        task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            
            if error != nil {
                print("Error while downloading from URL: \(String(describing: error))")
                DispatchQueue.main.async {
                    imageView.image = #imageLiteral(resourceName: "noImageFound.png")
                }
                return
            }
            
            DispatchQueue.main.async {
                if let data = data {
                    if let downloadedImage = UIImage(data: data) {
                        imageCache.setObject(downloadedImage, forKey: url.absoluteString as NSString)
                        imageView.image = downloadedImage
                    }
                }
            }
        })
        
        task?.resume()
    }
}
