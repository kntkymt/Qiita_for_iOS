//
//  RootViewController.swift
//  Qiita
//
//  Created by kntk on 2019/09/23.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {

    // MARK: - Property

    private(set) var currentViewController: UIViewController?

    // MARK: - Public

    func route(_ viewController: UIViewController, animated: Bool) {
        guard let currentViewController = currentViewController else {
            addChild(viewController)
            view.addSubview(viewController.view)
            viewController.didMove(toParent: self)
            self.currentViewController = viewController

            return
        }

        transition(from: currentViewController, to: viewController, animated: animated)
        self.currentViewController = viewController
    }

    // MARK: - Private

    private func transition(from fromViewController: UIViewController, to toViewController: UIViewController, animated: Bool) {
        fromViewController.willMove(toParent: nil)
        addChild(toViewController)
        toViewController.view.alpha = 0

        let duration = animated ? 0.2 : 0

        transition(from: fromViewController, to: toViewController, duration: duration, options: [], animations: {
            toViewController.view.alpha = 1
        }, completion: { _ in
            fromViewController.removeFromParent()
            toViewController.didMove(toParent: self)
            self.setNeedsStatusBarAppearanceUpdate()
        })
    }
}
