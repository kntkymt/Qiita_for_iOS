//
//  SplashViewController.swift
//  Qiita
//
//  Created by kntk on 2019/09/23.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit

final class SplashViewController: UIViewController {

    // MARK: - Lifecycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SceneRouter.shared.route(to: !AppContext.isFirstLaunch || Auth.shared.isSignedin ? .main : .login, animated: true)
        if !AppContext.isFirstLaunch || Auth.shared.isSignedin { AppContext.isFirstLaunch = false }
    }
}

// MARK: - Storyboardable

extension SplashViewController: Storyboardable {

    func inject(_ dependency: ()) {

    }
}
