//
//  User.swift
//  Qiita
//
//  Created by kntk on 2019/09/24.
//  Copyright © 2019 kntk. All rights reserved.
//

import Foundation

struct User: Codable, Identifiable {

    let id: String
    let name: String
    let description: String?
    let profileImageUrl: URL
    let itemsCount: Int
    let followeesCount: Int
    let followersCount: Int
}
