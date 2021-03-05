//
//  StockNavigationController.swift
//  Qiita
//
//  Created by kntk on 2019/09/28.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit

final class StockNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController = StockViewController(with: AppContainer.shared.stockRepository)
        setViewControllers([viewController], animated: false)
    }
}
