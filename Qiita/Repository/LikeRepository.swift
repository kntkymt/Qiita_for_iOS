//
//  LikeRepository.swift
//  Qiita
//
//  Created by kntk on 2021/03/05.
//  Copyright © 2021 kntk. All rights reserved.
//

import PromiseKit

protocol LikeRepository {

    /// 記事をいいねする
    func like(id: Item.ID) -> Promise<VoidModel>

    /// 記事のいいねを解除する
    func unlike(id: Item.ID) -> Promise<VoidModel>

    /// 記事をいいねしているかどうか確認する
    func checkIsLiked(id: Item.ID) -> Promise<VoidModel>
}
