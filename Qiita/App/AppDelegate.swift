//
//  AppDelegate.swift
//  Qiita
//
//  Created by kntk on 2019/09/23.
//  Copyright © 2019 kntk. All rights reserved.
//

import PluggableAppDelegate

@UIApplicationMain final class AppDelegate: PluggableApplicationDelegate {

    override var services: [ApplicationService] {
        return [
            DeepLinkApplicationService(),
            LoggerApplicationService(),
            SceneRouterApplicationService(),
            ReadEnvironmentVariableApplication()
        ]
    }
}
