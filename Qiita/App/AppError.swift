//
//  AppError.swift
//  Qiita
//
//  Created by kntk on 2019/09/24.
//  Copyright © 2019 kntk. All rights reserved.
//

import Foundation
import Moya

enum NetworkingError: Error {
    case unauthorized(message: String?)
    case badrequest(message: String?)
    case forbidden(message: String?)
    case notfound(message: String?)
    case `internal`(message: String?)
    case network
    case unknown

    struct Response: Decodable {
        let message: String
    }

    // MARK: - Initializer

    init(error: Error) {
        guard let moyaError = error as? MoyaError else {
            self = .unknown
            return
        }

        let message = try? JSONDecoder().decode(Response.self, from: moyaError.response?.data ?? Data()).message

        switch moyaError.response?.statusCode {
        case 400:
            self = .badrequest(message: message)
        case 401:
            self = .unauthorized(message: message)
        case 403:
            self = .forbidden(message: message)
        case 404:
            self = .notfound(message: message)
        case 500, 501, 502, 503, 504, 505:
            self = .internal(message: message)
        default:
            self = .network
        }
    }
}
