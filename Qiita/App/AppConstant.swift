//
//  AppConstant.swift
//  Qiita
//
//  Created by kntk on 2019/09/23.
//  Copyright © 2019 kntk. All rights reserved.
//

enum AppConstant {

    enum API {
        static let domain = "qiita.com"
        static let baseURL = "https://\(domain)/api/v2"
    }

    enum Auth {
        static let baseURL = "\(API.baseURL)/oauth/authorize"
        static let scope = "read_qiita write_qiita"
        static var clientId = ""
        static var clientSecret = ""
        static let keychainID = "qiita"
    }
}
