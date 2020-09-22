//
//  KeyChains.swift
//  Qiita
//
//  Created by kntk on 2019/10/13.
//  Copyright © 2019 kntk. All rights reserved.
//

import KeychainAccess

@propertyWrapper
struct KeyChain {
    let key: String

    var wrappedValue: String? {
        get {
            return KeyChains.standard.get(forKey: key)
        }
        set {
            KeyChains.standard.set(newValue: newValue, forKey: key)
        }
    }
}

struct KeyChains {

    // MARK: - Static

    static let standard = KeyChains()

    // MARK: - Property

    let keychain: Keychain

    // MARK: - Property

    func get(forKey key: String) -> String? {
        return keychain[key]
    }

    func set(newValue value: String?, forKey key: String) {
        guard let value = value else {
            keychain[key] = nil
            return
        }
        
        keychain[key] = value
    }

    // MARK: - Initializer

    private init() {
        keychain = Keychain(service: AppConstant.Auth.keychainID)
    }
}
