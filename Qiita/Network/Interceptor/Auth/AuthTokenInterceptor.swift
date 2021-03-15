//
//  AuthTokenInterceptor.swift
//  Qiita
//
//  Created by kntk on 2021/03/05.
//  Copyright © 2021 kntk. All rights reserved.
//

import Foundation
import Moya

final class AuthTokenInterceptor: Interceptor {

    // MARK: - Public

    func intercept<T>(_ target: T.Type, endpoint: Endpoint, done: @escaping MoyaProvider<T>.RequestResultClosure) where T: TargetType {
        guard let request = try? endpoint.urlRequest() else {
            done(.failure(.requestMapping(endpoint.url)))
            return
        }

        guard let accessToken = Auth.shared.accessToken else {
            if Auth.shared.isSignedin {
                done(.failure(.requestMapping("authorization token notfound")))
            } else {
                // アクセストークン取得API, 認可無しAPIの場合
                done(.success(request))
            }

            return
        }

        done(.success(self.createRequest(with: accessToken, from: request)))
    }

    // MARK: - Private

    private func createRequest(with token: String, from request: URLRequest) -> URLRequest {
        var request = request
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
