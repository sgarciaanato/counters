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
    case counters
}

class NetworkOperation {
    
    static let shared = NetworkOperation()
    private var urlComponents = URLComponents(string: "http://localhost:3000")
    private var dataTask : URLSessionTask?
    private let defaultSession = URLSession(configuration: .default)
    
    func request<T:Codable>(paths: [Path], completion : @escaping (Result<T?, Error>)->()) {
        
        urlComponents?.path = ""
        
        _ = paths.compactMap{ urlComponents?.path += "/\($0.rawValue)" }
            
        guard let url = urlComponents?.url else {
            return
        }
        
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse{
                if response.statusCode == 200 {
                    do {
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
