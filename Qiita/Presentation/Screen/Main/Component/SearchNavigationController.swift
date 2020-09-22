//
//  SearchNavigationController.swift
//  Qiita
//
//  Created by kntk on 2019/09/28.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit

final class SearchNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController = SearchViewController(with: ())
        setViewControllers([viewController], animated: false)
    }
}
