//
//  ItemService.swift
//  Qiita
//
//  Created by kntk on 2019/09/24.
//  Copyright © 2019 kntk. All rights reserved.
//

import PromiseKit

final class ItemService: ItemRepository {

    func getItems(page: Int) -> Promise<[Item]> {
        return API.shared.call(ItemTarget.getItems(page: page))
    }

    // FIXME: Optionalやめたい
    func getItems(with type: SearchType?, page: Int) -> Promise<[Item]> {
        switch type {
        case .word(let word):
            return API.shared.call(ItemTarget.getItemsByQuery(page: page, query: word))
            
        case .tag(let tag):
            return API.shared.call(TagTarget.getItems(page: page, id: tag.id))

        case .none:
            return getItems(page: page)
        }
    }

    // TODO: UserServiceに置く？
    func getItems(by user: User, page: Int, perPage: Int) -> Promise<[Item]> {
        return API.shared.call(UserTarget.getItems(page: page, perPage: perPage, id: user.id))
    }

    func getAuthenticatedUserItems(page: Int, perPage: Int) -> Promise<[Item]> {
        return API.shared.call(UserTarget.getAuthenticatedUserItems(page: page, perPage: perPage))
    }
}
