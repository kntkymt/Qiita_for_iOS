//
//  AuthTarget.swift
//  Qiita
//
//  Created by kntk on 2019/10/13.
//  Copyright © 2019 kntk. All rights reserved.
//

import Moya

enum AuthTarget {

    case getAccessToken(code: String)
    case deleteAccessToken(accessToken: String)
    case getAccount
}

// MARK: - BaseTarget

extension AuthTarget: BaseTarget {

    var path: String {
        switch self {
        case .getAccessToken:
            return "/access_tokens"

        case .deleteAccessToken(let accessToken):
            return "/access_tokens/\(accessToken)"

        case .getAccount:
            return "/authenticated_user"
        }
    }

    var method: Method {
        switch self {
        case .getAccessToken:
            return .post

        case .deleteAccessToken:
            return .delete

        case .getAccount:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getAccessToken(let code):
            let parameters: Parameters = [
                "client_id": AppConstant.Auth.clientId,
                "client_secret": AppConstant.Auth.clientSecret,
                "code": code
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)

        case .deleteAccessToken:
            return .requestPlain

        case .getAccount:
            return .requestPlain
        }
    }
}
