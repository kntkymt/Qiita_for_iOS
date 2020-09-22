//
//  DeepLinkApplicationService.swift
//  Qiita
//
//  Created by kntk on 2019/10/13.
//  Copyright © 2019 kntk. All rights reserved.
//

import PluggableAppDelegate

final class DeepLinkApplicationService: NSObject, ApplicationService {

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        Auth.shared.handleDeepLink(url: url)
        Logger.debug("DeepLink: \(url)")
        return true
    }
}
