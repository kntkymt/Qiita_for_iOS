//
//  ReadEnvironmentVariableApplication.swift
//  Qiita
//
//  Created by kntk on 2020/09/22.
//  Copyright © 2020 kntk. All rights reserved.
//

import PluggableAppDelegate

final class ReadEnvironmentVariableApplication: NSObject, ApplicationService {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

        guard let path = Bundle.main.path(forResource: ".env", ofType: nil) else {
            fatalError("Not found: '/path/to/.env'.\nPlease create .env file reference from .env.sample")
        }

        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let str = String(data: data, encoding: .utf8) ?? "Empty File"
            let clean = str.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "'", with: "")
            let envVars = clean.components(separatedBy: "\n")
            for envVar in envVars {
                let keyVal = envVar.components(separatedBy: "=")
                if keyVal.count == 2 {
                    setenv(keyVal[0], keyVal[1], 1)
                }
            }
        } catch {
            fatalError(error.localizedDescription)
        }

        let env = ProcessInfo.processInfo.environment
        AppConstant.Auth.clientId = env["QIITA_AUTH_CLIENT_ID"]!
        AppConstant.Auth.clientSecret = env["QIITA_AUTH_CLIENT_SECRET"]!

        return true
    }
}
