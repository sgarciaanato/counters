//
//  Cache.swift
//  Counters
//
//  Created by Samuel García on 26-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import Foundation

class Cache {
    
    static let shared = Cache()
    private let defaults = UserDefaults.standard
    let countersKey = "last-counter-key"
    
    func getData<T :Codable>() -> T?{
        guard let data : Data = defaults.object(forKey: countersKey) as? Data else { return nil }
        do {
            let t = try JSONDecoder().decode(T.self, from: data)
            return t
        } catch {
            debugPrint(error.localizedDescription)
        }
        return nil
    }
    
    func save(data: Any){
        defaults.set(data, forKey: countersKey)
        defaults.synchronize()
    }
    
}
