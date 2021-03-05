//
//  StockRepository.swift
//  Qiita
//
//  Created by kntk on 2021/03/05.
//  Copyright © 2021 kntk. All rights reserved.
//

import PromiseKit

protocol StockRepository {

    /// ストック記事一覧を取得する
    func getStocks(page: Int, perPage: Int) -> Promise<[Item]>

    /// 記事をストックする
    func stock(id: Item.ID) -> Promise<VoidModel>

    /// 記事のストックを解除する
    func unstock(id: Item.ID) -> Promise<VoidModel>

    /// 記事をストックしているか確認する
    func checkIsStocked(id: Item.ID) -> Promise<VoidModel>
}
