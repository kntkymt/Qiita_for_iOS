//
//  Interceptor.swift
//  Qiita
//
//  Created by kntk on 2021/03/05.
//  Copyright © 2021 kntk. All rights reserved.
//

import Foundation
import Moya

protocol Interceptor {

    func intercept<T: TargetType>(_ target: T.Type, endpoint: Endpoint, done: @escaping MoyaProvider<T>.RequestResultClosure)
}
