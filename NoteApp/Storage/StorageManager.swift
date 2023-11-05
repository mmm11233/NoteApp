//
//  StorageManager.swift
//  NoteApp
//
//  Created by Mariam Joglidze on 06.11.23.
//

import Foundation

struct StorageManager {
    
    static let shared: StorageManager = .init()
    
    private init() {}
    
    private let userDefaults = UserDefaults.standard
    private let key = "StorageManager"
    
    // Save an array of tuples to UserDefaults
    func saveTupleArray(_ array: [(String, String)]) {
        let arrayOfDictionaries = array.map { tuple in
            ["key1": tuple.0, "key2": tuple.1]
        }
        userDefaults.set(arrayOfDictionaries, forKey: key)
    }
    
    // Retrieve an array of tuples from UserDefaults
    func getTupleArray() -> [(String, String)]? {
        if let retrievedDictionaries = userDefaults.array(forKey: key) as? [[String: Any]] {
            let retrievedTuples = retrievedDictionaries.compactMap { dictionary in
                if let value1 = dictionary["key1"] as? String, let value2 = dictionary["key2"] as? String {
                    return (value1, value2)
                }
                return nil
            }
            return retrievedTuples
        }
        return nil
    }
    
    func deleteTupleAtIndex(_ index: Int) {
           if var currentArray = getTupleArray(), index >= 0, index < currentArray.count {
               currentArray.remove(at: index)
               let arrayOfDictionaries = currentArray.map { tuple in
                   ["key1": tuple.0, "key2": tuple.1]
               }
               userDefaults.set(arrayOfDictionaries, forKey: key)
           }
       }
}
