//
//  NetworkCommunicator.swift
//  FlickrImageSearchDemo
//
//  Created by Rohit Negi on 4/30/19.
//  Copyright © 2019 Rohit. All rights reserved.
//

import Foundation

public typealias CompletionHandlerWithModal<T> = ((T)->Void)?

class NetworkCommunicator {
    
    private var isRequestInProgress = false
    
    func makeRequest(with url : URL, params : [String : String] = [String : String](), method : RequestType = .GET, onCompletion : CompletionHandlerWithModal<Result<Data>> = nil){
        
        if !isRequestInProgress{
            isRequestInProgress = true
            
            var request = URLRequest(url: url)
            let session = URLSession.shared
            request.httpMethod = method.rawValue
        
            let task = session.dataTask(with: request as URLRequest, completionHandler: {[weak self] data, response, error -> Void in
                
                guard let strongSelf = self else{
                    return
                }
                
                if let err = error as NSError?{
                   if err.code == NSURLErrorTimedOut{
                        onCompletion?(.failure(NSError.error(errorCode: ErrorCodes.timeOut)))
                    }
                    else{
                        onCompletion?(.failure(err))
                    }
                    return
                }
                
                if let statusCode = response?.httpStatusCode {
                    if statusCode == 204 || statusCode == 404 {
                        onCompletion?(.failure(NSError.error(errorCode: ErrorCodes.noNextPage)))
                        return
                    }
                }
                
                guard let data = data else{
                    onCompletion?(.failure(nil))
                    return
                }
                
                print("Response: \(String(describing: String(data: data, encoding: .utf8)))")
                strongSelf.isRequestInProgress = false
                onCompletion?(.success(data))
            })
            task.resume()
        }
        else{
            onCompletion?(.failure(NSError.error(errorCode: ErrorCodes.requestInProgress)))
        }
    }
    
    func makeRequest<T : Codable>(with url : URL, params : [String : String] = [String : String](), method : RequestType = .GET, onCompletion : CompletionHandlerWithModal<Result<T>> = nil){
        
            self.makeRequest(with: url, params: params, method: method) { (resultData : Result<Data>) in
                switch resultData{
                case .success(let data):
                    do{
                        let aDecoder = JSONDecoder()
                        
                        let decodedModel = try aDecoder.decode(T.self, from: data)
                        onCompletion?(.success(decodedModel))
                    }
                    catch let e{
                        print("Error : \(e)")
                        onCompletion?(.failure(e))
                    }
                    break
                case.failure(let err) :
                    onCompletion?(.failure(err))
                }
            }
    }
}

extension URLResponse {
    
    var httpStatusCode: Int? {
        return (self as? HTTPURLResponse)?.statusCode
    }
}
