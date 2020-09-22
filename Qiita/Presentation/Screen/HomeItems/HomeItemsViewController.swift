//
//  HomeItemsViewController.swift
//  Qiita
//
//  Created by kntk on 2019/10/24.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture
import AMScrollingNavbar

final class HomeItemsViewController: UIViewController {

    // MARK: - Outlet

    @IBOutlet private weak var containerView: UIView!

    // MARK: - Property

    private var itemsViewController: ItemsViewController! {
        didSet {
            itemsViewController.delegate = self
        }
    }
    private var itemService: ItemService!

    private var isLoading = false
    private var searchType: SearchType?
    private var nextPage = 2

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fd_prefersNavigationBarHidden = true
        addChild(itemsViewController, to: containerView)
        setInitialItems()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.stopFollowingScrollView(showingNavbar: navigationController.state == .expanded)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let nav = navigationController as? ScrollingNavigationController {
            nav.followScrollView(itemsViewController.tableView, delay: 50.0)
        }
        adjustInset()
    }

    // MARK: - Private

    private func adjustInset() {
        if let navigationController = navigationController as? ScrollingNavigationController,
            navigationController.state == .expanded {
            let inset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
            itemsViewController.tableView.contentInset = inset
            itemsViewController.tableView.scrollIndicatorInsets = inset
        }
    }

    private func setInitialItems() {
        if isLoading { return }
        isLoading = true
        itemService.getItems(with: searchType, page: 1)
            .done { items in
                self.itemsViewController.items = items
                self.itemsViewController.refreshControl.endRefreshing()
                self.isLoading = false
            }.catch { error in
                Logger.error(error)
                self.itemsViewController.refreshControl.endRefreshing()
                self.isLoading = false
            }
    }

    private func setMoreItems(page: Int) {
        if isLoading { return }
        itemsViewController.tableView.startFooterLoading()
        isLoading = true
        itemService.getItems(with: searchType, page: nextPage)
            .done { items in
                self.nextPage += 1
                self.itemsViewController.items += items
                self.isLoading = false
                self.itemsViewController.tableView.stopFooterLoading()
            }.catch { error in
                Logger.error(error)
                self.isLoading = false
                self.itemsViewController.tableView.stopFooterLoading()
            }
    }
}

// MARK: - StoryboardInstantiatable

extension HomeItemsViewController: Storyboardable {

    func inject(_ dependency: SearchType?) {
        self.itemsViewController = ItemsViewController(with: nil)
        self.itemService = ItemService()
        self.searchType = dependency
    }
}

// MARK: - ItemsViewControllerDelegate

extension HomeItemsViewController: ItemsViewControllerDelegate {

    func itemsViewControllerDidReload(_ itemsViewController: ItemsViewController) {
        setInitialItems()
    }

    func itemsViewControllerDidReachButtom(_ itemsViewController: ItemsViewController) {
        setMoreItems(page: nextPage)
    }
}
