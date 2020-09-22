//
//  UserService.swift
//  Qiita
//
//  Created by kntk on 2019/10/13.
//  Copyright © 2019 kntk. All rights reserved.
//

import PromiseKit

struct UserService {

    func getUser(id: User.ID) -> Promise<User> {
        return API.shared.call(UserTarget.get(id: id))
    }
}
