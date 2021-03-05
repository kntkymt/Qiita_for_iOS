//
//  TagService.swift
//  Qiita
//
//  Created by kntk on 2019/10/05.
//  Copyright © 2019 kntk. All rights reserved.
//

import PromiseKit

final class TagService: TagRepository {

    func getTags(page: Int, perPage: Int, sort: String) -> Promise<[ItemTag]> {
        return API.shared.call(TagTarget.getTags(page: page, perPage: perPage, sort: sort))
    }

    func follow(id: ItemTag.ID) -> Promise<VoidModel> {
        return API.shared.call(TagTarget.follow(id: id))
    }

    func unfollow(id: ItemTag.ID) -> Promise<VoidModel> {
        return API.shared.call(TagTarget.unfollow(id: id))
    }

    func checkIsFollowed(id: ItemTag.ID) -> Promise<VoidModel> {
        return API.shared.call(TagTarget.checkIsFollowed(id: id))
    }
}
