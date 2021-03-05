//
//  SceneRouter.swift
//  Qiita
//
//  Created by kntk on 2019/09/23.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit

final class SceneRouter {

    enum Scene {
        case splash
        case login
        case main

        var viewController: UIViewController {
            switch self {
            case .splash: return SplashViewController(with: AppContainer.shared.authRepository)
            case .login: return LoginViewController(with: AppContainer.shared.authRepository)
            case .main: return MainViewController(with: ())
            }
        }
    }

    // MARK: - Static

    static let shared = SceneRouter()

    // MARK: - Property

    weak var rootViewController: RootViewController!

    // MARK: - Initializer

    private init() {}

    // MARK: - Public

    func route(to scene: Scene, animated: Bool) {
        rootViewController.route(scene.viewController, animated: animated)
    }
}
