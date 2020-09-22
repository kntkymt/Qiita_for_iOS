//
//  LoggerApplicationService.swift
//  Qiita
//
//  Created by kntk on 2019/09/23.
//  Copyright © 2019 kntk. All rights reserved.
//

import PluggableAppDelegate
import SwiftyBeaver

typealias Logger = SwiftyBeaver

final class LoggerApplicationService: NSObject, ApplicationService {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        Logger.setup()
        Logger.info("💫 Application will finish launching")
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        Logger.info("💫 Application did enter background")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        Logger.info("💫 Application will enter foreground")
    }
}

extension Logger {

    static func setup() {
        #if targetEnvironment(simulator)
        let destination = ConsoleDestination()
        SwiftyBeaver.addDestination(destination)
        #endif
    }
}
