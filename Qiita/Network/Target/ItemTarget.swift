//
//  ItemTarget.swift
//  Qiita
//
//  Created by kntk on 2019/10/13.
//  Copyright © 2019 kntk. All rights reserved.
//

import Moya

enum ItemTarget {

    case getItems(page: Int)
    case getItemsByQuery(page: Int, query: String)
    case stock(id: Item.ID)
    case unstock(id: Item.ID)
    case checkIsStocked(id: Item.ID)
    case like(id: Item.ID)
    case unlike(id: Item.ID) // FIXME: unlikeは「似てない」
    case checkIsLiked(id: Item.ID)
}

// MARK: - BaseTarget

extension ItemTarget: BaseTarget {

    var path: String {
        switch self {
        case .getItems:
            return "/items"

        case .getItemsByQuery:
            return "/items"

        case .stock(let id):
            return "/items/\(id)/stock"

        case .unstock(let id):
            return "/items/\(id)/stock"

        case .checkIsStocked(let id):
            return "/items/\(id)/stock"

        case .like(let id):
            return "/items/\(id)/like"

        case .unlike(let id):
            return "/items/\(id)/like"

        case .checkIsLiked(let id):
            return "/items/\(id)/like"
        }
    }

    var method: Method {
        switch self {
        case .getItems:
            return .get

        case .getItemsByQuery:
            return .get

        case .stock:
            return .put

        case .unstock:
            return .delete

        case .checkIsStocked:
            return .get

        case .like:
            return .put

        case .unlike:
            return .delete

        case .checkIsLiked:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getItems(let page):
            let parameters: Parameters = [
                "page": page
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)

        case .getItemsByQuery(let page, let query):
            let parameters: Parameters = [
                "page": page,
                "query": query
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)

        case .stock:
            return .requestPlain

        case .unstock:
            return .requestPlain

        case .checkIsStocked:
            return .requestPlain

        case .like:
            return .requestPlain

        case .unlike:
            return .requestPlain

        case .checkIsLiked:
            return .requestPlain
        }
    }
}
