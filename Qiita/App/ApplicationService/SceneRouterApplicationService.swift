//
//  SceneRouterApplicationService.swift
//  Qiita
//
//  Created by kntk on 2019/09/23.
//  Copyright © 2019 kntk. All rights reserved.
//

import PluggableAppDelegate

final class SceneRouterApplicationService: NSObject, ApplicationService {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        SceneRouter.shared.rootViewController = window?.rootViewController as? RootViewController
        SceneRouter.shared.route(to: .splash, animated: true)
        return true
    }
}
