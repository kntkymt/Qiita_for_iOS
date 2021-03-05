//
//  AppEnvironment.swift
//  Qiita
//
//  Created by kntk on 2021/03/05.
//  Copyright © 2021 kntk. All rights reserved.
//

import Foundation

enum BuildConfig {
    case debug
    case release
}

final class AppEnvironment {

    // MARK: - Static

    static let shared = AppEnvironment()

    // MARK: - Public

    var buildConfig: BuildConfig {
        #if DEBUG
        return .debug
        #else
        return .release
        #endif
    }
}
