//
//  AuthRepository.swift
//  Qiita
//
//  Created by kntk on 2021/03/05.
//  Copyright © 2021 kntk. All rights reserved.
//

import PromiseKit

protocol AuthRepository {

    /// ログイン中かどうか
    var isSignedin: Bool { get }

    /// ログイン中のユーザーを取得する
    func getCurrentUser() -> Promise<User>

    /// ログインする
    func signin() -> Promise<AuthModel>

    /// ログアウトする
    func signout() -> Promise<Void>
}
