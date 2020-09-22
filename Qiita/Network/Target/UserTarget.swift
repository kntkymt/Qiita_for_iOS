//
//  UserTarget.swift
//  Qiita
//
//  Created by kntk on 2019/10/13.
//  Copyright © 2019 kntk. All rights reserved.
//

import Moya

enum UserTarget {

    case get(id: User.ID)
    case getItems(page: Int, perPage: Int, id: User.ID)
    case getAuthenticatedUserItems(page: Int, perPage: Int)
    case getStocks(page: Int, perPage: Int, id: User.ID)
}

// MARK: - BaseTarget

extension UserTarget: BaseTarget {

    var path: String {
        switch self {
        case .get(let id):
            return "/users/\(id)"

        case .getItems(let param):
            return "/users/\(param.id)/items"

        case .getAuthenticatedUserItems:
            return "authenticated_user/items"

        case .getStocks(let param):
            return "/users/\(param.id)/stocks"
        }
    }

    var method: Method {
        switch self {
        case .get:
            return .get

        case .getItems:
            return .get

        case .getAuthenticatedUserItems:
            return .get

        case .getStocks:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .get:
            return .requestPlain

        case .getItems(let page, let perPage, _):
            let parameters: Parameters = [
                "page": page,
                "per_page": perPage
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)

        case .getAuthenticatedUserItems(let page, let perPage):
            let parameters: Parameters = [
                "page": page,
                "per_page": perPage
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)

        case .getStocks(let page, let perPage, _):
            let parameters: Parameters = [
                "page": page,
                "per_page": perPage
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}
