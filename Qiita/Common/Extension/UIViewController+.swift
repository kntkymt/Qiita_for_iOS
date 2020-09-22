//
//  UIViewController+.swift
//  Qiita
//
//  Created by kntk on 2019/09/28.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit

extension UIViewController {

    func addChild(_ viewController: UIViewController, to container: UIView) {
        addChild(viewController)
        container.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: container.topAnchor),
            viewController.view.leftAnchor.constraint(equalTo: container.leftAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            viewController.view.rightAnchor.constraint(equalTo: container.rightAnchor)
            ])
        didMove(toParent: self)
    }

    func topPresentedViewController() -> UIViewController {
        guard let viewController = presentedViewController else {
            return self
        }

        return viewController.topPresentedViewController()
    }

    func bottomPresentingViewController() -> UIViewController {
        guard let viewController = presentingViewController else {
            return self
        }

        return viewController.bottomPresentingViewController()
    }
}
