//
//  NetworkingOperation.swift
//  Counters
//
//  Created by Samuel García on 24-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import Foundation

enum Path : String {
    case api
    case v1
    case counter
    case counters
    case inc
    case dec
}

class NetworkOperation {
    
    static let shared = NetworkOperation()
    private var urlComponents = URLComponents(string: "http://29303e736327.ngrok.io")
    private var dataTask : URLSessionTask?
    private let defaultSession = URLSession(configuration: .default)
    
    func request<T:Codable>(paths: [Path], httpMethod : String = "GET", httpBody : [String:Any]?, completion : @escaping (Result<T?, Error>)->()) {
        
        urlComponents?.path = ""
        
        _ = paths.compactMap{ urlComponents?.path += "/\($0.rawValue)" }
            
        guard let url = urlComponents?.url else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = httpMethod
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let httpBody = httpBody {
            do {
                let jsonData = try? JSONSerialization.data(withJSONObject: httpBody, options: .prettyPrinted)
                urlRequest.httpBody = jsonData
            }
        }
        
        dataTask = defaultSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse{
                if response.statusCode == 200 {
                    do {
                        Cache.shared.save(data: data)
                        let t = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(t))
                    } catch {
                        completion(.failure(NSError(domain:"", code:response.statusCode, userInfo:
                            [NSLocalizedDescriptionKey : "Parsing error"]
                        )))
                    }
                }else{
                    completion(.failure(NSError(domain:"", code:response.statusCode, userInfo:
                        [NSLocalizedDescriptionKey : "Status code error"]
                    )))
                }
            } else {
                completion(.failure(NSError(domain:"", code:0, userInfo:
                    [NSLocalizedDescriptionKey : "Unknown Error"]
                )))
            }
        }
        dataTask?.resume()
    }
    
}
