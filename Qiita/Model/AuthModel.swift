//
//  AuthModel.swift
//  Qiita
//
//  Created by kntk on 2019/10/13.
//  Copyright © 2019 kntk. All rights reserved.
//

import Foundation

struct AuthModel: Codable {

    let clientId: String
    let scopes: [String]
    let token: String
}
