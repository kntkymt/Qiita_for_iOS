//
//  UserService.swift
//  Qiita
//
//  Created by kntk on 2021/03/05.
//  Copyright © 2021 kntk. All rights reserved.
//

import PromiseKit

protocol UserRepository {

    /// 特定のユーザーを取得する
    func getUser(id: User.ID) -> Promise<User>
}
