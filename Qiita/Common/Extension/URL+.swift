//
//  URL+.swift
//  Qiita
//
//  Created by kntk on 2019/10/13.
//  Copyright © 2019 kntk. All rights reserved.
//

import Foundation

extension URL {

    func addQuery(name: String, value: String?) -> URL? {
        return self.queryItemsAdded([URLQueryItem(name: name, value: value)])
    }

    func queryItemsAdded(_ queryItems: [URLQueryItem]) -> URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: nil != self.baseURL) else {
            return nil
        }
        components.queryItems = queryItems + (components.queryItems ?? [])
        return components.url!
    }

    var queryParameters: [String: String] {
        var params = [String: String]()

        guard let comps = URLComponents(string: self.absoluteString) else {
            return params
        }
        guard let queryItems = comps.queryItems else { return params }

        queryItems.forEach { queryItem in
            params[queryItem.name] = queryItem.value
        }

        return params
    }
}
