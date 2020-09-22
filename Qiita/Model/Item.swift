//
//  Item.swift
//  Qiita
//
//  Created by kntk on 2019/09/24.
//  Copyright © 2019 kntk. All rights reserved.
//

import Foundation

struct Item: Codable, Identifiable {

    let title: String
    let id: String
    let url: URL
    let likesCount: Int
    let createdAt: Date
    let user: User
}
