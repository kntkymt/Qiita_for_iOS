//
//  ItemRepository.swift
//  Qiita
//
//  Created by kntk on 2021/03/05.
//  Copyright © 2021 kntk. All rights reserved.
//

import PromiseKit

protocol ItemRepository {

    /// 新着記事一覧を取得する
    func getItems(page: Int) -> Promise<[Item]>

    /// 新着記事一覧から検索する
    func getItems(with type: SearchType?, page: Int) -> Promise<[Item]>

    /// 特定のユーザーの記事一覧を取得する
    func getItems(by user: User, page: Int, perPage: Int) -> Promise<[Item]>

    /// 自分の記事一覧を取得する
    func getAuthenticatedUserItems(page: Int, perPage: Int) -> Promise<[Item]>
}
