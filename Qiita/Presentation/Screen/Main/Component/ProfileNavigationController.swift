//
//  ProfileNavigationController.swift
//  Qiita
//
//  Created by kntk on 2019/10/12.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit

final class ProfileNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController = ProfileViewController(with: AppContainer.shared.itemRepository)
        setViewControllers([viewController], animated: false)
    }
}
