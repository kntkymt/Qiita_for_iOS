//
//  LoggerPlugin.swift
//  Qiita
//
//  Created by kntk on 2019/09/24.
//  Copyright © 2019 kntk. All rights reserved.
//

import Moya
import Result

struct LoggerPlugin: PluginType {

    func willSend(_ request: RequestType, target: TargetType) {
        request.request.map { Logger.debug($0.curlString) }
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        Logger.debug(result.description)
    }
}
