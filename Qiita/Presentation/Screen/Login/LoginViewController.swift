//
//  LoginViewController.swift
//  Qiita
//
//  Created by kntk on 2019/09/23.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Private

    private func presentMainViewController() {
        SceneRouter.shared.route(to: .main, animated: true)
    }

    // MARK: - Action
    
    @IBAction private func signinButtonDidTap(_ sender: Any) {
        Auth.shared.signin()
            .done { auth in
                Logger.debug(auth)
                AppContext.isFirstLaunch = false
                self.presentMainViewController()
            }.catch { error in
                Logger.error(error)
            }
    }

    @IBAction private func withoutSigninButtonDidTap(_ sender: Any) {
        AppContext.isFirstLaunch = false
        presentMainViewController()
    }
}

// MARK: - Storyboardable

extension LoginViewController: Storyboardable {

    func inject(_ dependency: ()) {
    }
}
