//
//  StockService.swift
//  Qiita
//
//  Created by kntk on 2019/10/13.
//  Copyright © 2019 kntk. All rights reserved.
//

import PromiseKit

final class StockService: StockRepository {

    func getStocks(page: Int, perPage: Int) -> Promise<[Item]> {
        return Auth.shared.currentUser
            .then { user in
                API.shared.call(UserTarget.getStocks(page: page, perPage: perPage, id: user.id))
            }
    }

    func stock(id: Item.ID) -> Promise<VoidModel> {
        return API.shared.call(ItemTarget.stock(id: id))
    }

    func unstock(id: Item.ID) -> Promise<VoidModel> {
        return API.shared.call(ItemTarget.unstock(id: id))
    }

    func checkIsStocked(id: Item.ID) -> Promise<VoidModel> {
        return API.shared.call(ItemTarget.checkIsStocked(id: id))
    }
}
