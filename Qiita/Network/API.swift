//
//  API.swift
//  Qiita
//
//  Created by kntk on 2019/09/23.
//  Copyright © 2019 kntk. All rights reserved.
//

import Moya
import PromiseKit

final class API {

    // MARK: - Static

    static let shared = API()

    // MARK: - Property

    private let provider: MoyaProvider<MultiTarget>

    private let decoder: JSONDecoder = {        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return decoder
    }()

    // MARK: - Public

   func call<T: Decodable, Target: TargetType>(_ request: Target) -> Promise<T> {
        let target = MultiTarget(request)
        return Promise { resolver in
            self.provider.request(target) { response in
                switch response.result {
                case .success(let result):
                    do {
                        // FIXME: 204の扱い
                        if result.statusCode == 204 {
                            guard let decoded = VoidModel() as? T else { throw NetworkingError.network }
                            resolver.fulfill(decoded)
                        } else {
                            resolver.fulfill(try self.decoder.decode(T.self, from: result.data))
                        }
                    } catch {
                        resolver.reject(error)
                    }
                case .failure(let error):
                    resolver.reject(NetworkingError(error: error))
                }
            }
        }
    }

    // MARK: - Initializer

    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 30

        let manager = Manager(configuration: configuration)
        manager.startRequestsImmediately = false

        provider = MoyaProvider<MultiTarget>(manager: manager, plugins: [LoggerPlugin()])
    }
}
