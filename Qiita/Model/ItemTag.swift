//
//  ItemTag.swift
//  Qiita
//
//  Created by kntk on 2019/10/01.
//  Copyright © 2019 kntk. All rights reserved.
//

import Foundation

struct ItemTag: Codable, Identifiable {

    let iconUrl: URL?
    let followersCount: Int
    let id: String
    let itemsCount: Int
}
