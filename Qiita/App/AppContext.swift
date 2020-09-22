//
//  AppContext.swift
//  Qiita
//
//  Created by kntk on 2019/09/24.
//  Copyright © 2019 kntk. All rights reserved.
//

import Foundation

enum AppContext {

    @UserDefault(key: "isFirstLaunch", defaultValue: true)
    static var isFirstLaunch: Bool
}

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
