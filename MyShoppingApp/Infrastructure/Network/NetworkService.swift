//
//  NetworkService.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 23/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import Foundation

public protocol NetworkSessionManager {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler)
}

public class DefaultNetworkSessionManager: NetworkSessionManager {
    public init() {}
    public func request(_ request: URLRequest,
                        completion: @escaping CompletionHandler) {
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
    }
}

public protocol NetworkService {
    typealias CompletionHandler = (Result<Data?, Error>) -> Void
    
    func request(urlString: String, completion: @escaping CompletionHandler)
}

public final class DefaultNetworkService {
    
    private let sessionManager: NetworkSessionManager
    
    public init(sessionManager: NetworkSessionManager = DefaultNetworkSessionManager()) {
        self.sessionManager = sessionManager
    }
    
    private func request(request: URLRequest, completion: @escaping CompletionHandler) {
        
        sessionManager.request(request) { data, response, requestError in
            
            if let requestError = requestError {
                completion(.failure(requestError))
            } else {
                completion(.success(data))
            }
        }
    }
}

extension DefaultNetworkService: NetworkService {
    
    public func request(urlString: String, completion: @escaping CompletionHandler) {
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest.init(url: url)
            request(request: urlRequest, completion: completion)
        } else {
            completion(.failure(NSError(domain:"", code: 1, userInfo:nil)))
        }
    }
}
