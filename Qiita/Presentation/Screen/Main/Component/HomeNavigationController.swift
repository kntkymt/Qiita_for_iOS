//
//  HomeNavigationController.swift
//  Qiita
//
//  Created by kntk on 2019/09/28.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit
import AMScrollingNavbar

final class HomeNavigationController: ScrollingNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController = HomeViewController(with: ())
        setViewControllers([viewController], animated: false)
    }
}
