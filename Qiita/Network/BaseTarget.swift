//
//  APITargetType.swift
//  Qiita
//
//  Created by kntk on 2019/09/23.
//  Copyright © 2019 kntk. All rights reserved.
//

import Moya

protocol BaseTarget: TargetType {
}

extension BaseTarget {

    var baseURL: URL {
        return URL(string: AppConstant.API.baseURL)!
    }

    var headers: [String: String]? {
        guard let token = Auth.shared.accessToken else {
            return [:]
        }

        return ["Authorization": "Bearer \(token)"]
    }

    var validationType: ValidationType {
        return .successCodes
    }

    var sampleData: Data {
        return Data()
    }
}

typealias Parameters = [String: Any]
