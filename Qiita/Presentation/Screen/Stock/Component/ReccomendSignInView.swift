//
//  ReccomendSignInView.swift
//  Qiita
//
//  Created by kntk on 2019/10/27.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit

final class ReccomendSignInView: UIView {

    // MARK: - Action

    @IBAction private func signInButtonDidTap(_ sender: Any) {
        Auth.shared.signin()
            .done { _ in
                SceneRouter.shared.route(to: .splash, animated: true)
            }.catch { error in
                Logger.error(error)
            }
    }
}

// MARK: - NibInstantiatable

extension ReccomendSignInView: NibInstantiatable {

    func inject(_ dependency: ()) {
    }
}
