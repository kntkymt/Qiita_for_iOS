//
//  LikeService.swift
//  Qiita
//
//  Created by kntk on 2019/10/27.
//  Copyright © 2019 kntk. All rights reserved.
//

import PromiseKit

final class LikeService: LikeRepository {

    func like(id: Item.ID) -> Promise<VoidModel> {
        return API.shared.call(ItemTarget.like(id: id))
    }

    func unlike(id: Item.ID) -> Promise<VoidModel> {
        return API.shared.call(ItemTarget.unlike(id: id))
    }

    func checkIsLiked(id: Item.ID) -> Promise<VoidModel> {
        return API.shared.call(ItemTarget.checkIsLiked(id: id))
    }
}
