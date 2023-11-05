//
//  KeyChain.swift
//  NoteApp
//
//  Created by Mariam Joglidze on 05.11.23.
//

import Foundation
import Security

class KeychainManager {
    static let serviceName = "YourAppName"
    
    static func saveUsernamePassword(username: String, password: String) {
        guard let passwordData = password.data(using: .utf8) else { return }
        
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecValueData as String: passwordData,
        ]
        if SecItemAdd(attributes as CFDictionary, nil) == noErr {
            print("User saved successfully in the keychain")
        } else {
            print("Something went wrong trying to save the user in the keychain")
        }
    }
    
    static func retrievePasswordForUsername(username: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            if let existingItem = item as? [String: Any],
               let username = existingItem[kSecAttrAccount as String] as? String,
               let passwordData = existingItem[kSecValueData as String] as? Data,
               let password = String(data: passwordData, encoding: .utf8)
            {
                print(username)
                print(password)
                return password
            }
        } else {
            print("Something went wrong trying to find the user in the keychain")
        }
        return nil
    }
    
    static func deletePasswordForUsername(username: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: username
        ]
        SecItemDelete(query as CFDictionary)
    }
}
