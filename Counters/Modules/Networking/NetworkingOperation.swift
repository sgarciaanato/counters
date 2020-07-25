//
//  NetworkingOperation.swift
//  Counters
//
//  Created by Samuel García on 24-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import Foundation

class NetworkOperation {
    
    static let shared = NetworkOperation()
    private var url = "http://localhost:3000"
    private var dataTask : URLSessionTask?
    private let defaultSession = URLSession(configuration: .default)
    private var errorMessage : String?
    
    func get(endpoint: String, completion : @escaping (Data?, String?)->()) {
        
        let composedUrl = url + endpoint
        
        debugPrint(composedUrl)
        
        if var urlComponents = URLComponents(string: composedUrl) {
            urlComponents.query = ""
            
            guard let url = urlComponents.url else {
                return
            }
            
            dataTask =
                defaultSession.dataTask(with: url) { [weak self] data, response, error in
                    
                    defer {
                        self?.dataTask = nil
                    }
                    
                    if let error = error {
                        self?.errorMessage? += "DataTask error: " + error.localizedDescription + "\n"
                        completion(nil, self?.errorMessage ?? "")
                    } else if let data = data, let response = response as? HTTPURLResponse{
                        if response.statusCode == 200 {
                            completion(data, nil)
                        }else{
                            completion(data, "\(response.statusCode)")
                        }
                    } else {
                        completion(nil, "Unknown Error")
                    }
            }
            dataTask?.resume()
        }else{
            completion(nil, "URL compose error")
        }
    }
    
}
