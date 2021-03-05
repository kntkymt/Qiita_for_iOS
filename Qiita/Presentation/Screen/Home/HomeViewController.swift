//
//  HomeViewController.swift
//  Qiita
//
//  Created by kntk on 2019/09/28.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit
import TabPageViewController

final class HomeViewController: UIViewController {

    // MARK: - Outlet

    @IBOutlet private weak var containerView: UIView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabPage()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        WKWebViewWarmupper.shared.warmupUpToSize()
        if let navigationController = navigationController as? HomeNavigationController {
            navigationController.showNavbar(animated: false)
        }
    }

    // MARK: - Private

    private func setupTabPage() {
        let tabPageViewController = TabPageViewController()
        tabPageViewController.isInfinity = true
        tabPageViewController.tabItems = [
            (HomeItemsViewController(with: (searchType: nil, itemRepository: AppContainer.shared.itemRepository)), "新着"),
            (HomeItemsViewController(with: (searchType: .word("Swift"), itemRepository: AppContainer.shared.itemRepository)), "Swift"),
            (HomeItemsViewController(with: (searchType: .word("iOS"), itemRepository: AppContainer.shared.itemRepository)), "iOS"),
            (HomeItemsViewController(with: (searchType: .word("Kotlin"), itemRepository: AppContainer.shared.itemRepository)), "Kotlin"),
            (HomeItemsViewController(with: (searchType: .word("Android"), itemRepository: AppContainer.shared.itemRepository)), "Android")
        ]
        tabPageViewController.option.tabHeight = 44
        tabPageViewController.option.isTranslucent = false
        tabPageViewController.option.currentColor = UIColor(named: "Brand")!

        addChild(tabPageViewController, to: containerView)
    }
}

// MARK: - Storyboardable

extension HomeViewController: Storyboardable {

    func inject(_ dependency: ()) {

    }
}
