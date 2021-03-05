//
//  TagRepository.swift
//  Qiita
//
//  Created by kntk on 2021/03/05.
//  Copyright © 2021 kntk. All rights reserved.
//

import PromiseKit

protocol TagRepository {

    /// タグ一覧を取得する
    func getTags(page: Int, perPage: Int, sort: String) -> Promise<[ItemTag]>

    /// タグをフォローする
    func follow(id: ItemTag.ID) -> Promise<VoidModel>

    /// タグのフォローを外す
    func unfollow(id: ItemTag.ID) -> Promise<VoidModel>

    /// タグをフォローしているか確かめる
    func checkIsFollowed(id: ItemTag.ID) -> Promise<VoidModel>
}
