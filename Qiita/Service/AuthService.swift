//
//  AuthService.swift
//  Qiita
//
//  Created by kntk on 2021/03/05.
//  Copyright © 2021 kntk. All rights reserved.
//

import PromiseKit

final class AuthService: AuthRepository {

    var isSignedin: Bool {
        return Auth.shared.isSignedin
    }

    func getCurrentUser() -> Promise<User> {
        return Auth.shared.currentUser
    }

    func signin() -> Promise<AuthModel> {
        return Auth.shared.signin()
    }

    func signout() -> Promise<Void> {
        return Auth.shared.signout()
    }
}
