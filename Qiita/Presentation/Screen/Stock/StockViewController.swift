//
//  StockViewController.swift
//  Qiita
//
//  Created by kntk on 2019/09/28.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture
import ReusableKit
import Instantiate

final class StockViewController: UIViewController {

    enum Reusable {
        static let cell = ReusableCell<ItemTableViewCell>(nibName: "ItemTableViewCell")
    }

    // MARK: - Outlet

    @IBOutlet private weak var emptyView: UIView!
    @IBOutlet private weak var containerView: UIView!

    // MARK: - Property

    private var itemsViewController: ItemsViewController! {
        didSet {
            itemsViewController.delegate = self
        }
    }
    private var stockRepository: StockRepository!

    private var nextPage = 2
    private var isLoading = false

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fd_prefersNavigationBarHidden = true

        guard Auth.shared.isSignedin else {
            showReccomendSignInView()
            return
        }
        addChild(itemsViewController, to: containerView)
        setInitialItems()
    }

    // MARK: - Private

    private func showReccomendSignInView() {
        let reccomendView = ReccomendSignInView(with: ())
        view.addSubview(reccomendView)
        reccomendView.makeEdgesEqual(to: containerView)
    }

    private func setInitialItems() {
        if isLoading { return }
        isLoading = true
        stockRepository.getStocks(page: 1, perPage: 10)
            .done { items in
                if items.isEmpty {
                    self.itemsViewController.showEmptyView(view: self.emptyView)
                } else {
                    self.itemsViewController.hideEmptyView()
                }
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
        isLoading = true
        self.itemsViewController.tableView.startFooterLoading()
        stockRepository.getStocks(page: nextPage, perPage: 10)
            .done { items in
                self.nextPage += 1
                self.itemsViewController.items += items
                self.isLoading = false
                self.itemsViewController.tableView.stopFooterLoading()
            }.catch { error in
                print(error)
                self.isLoading = false
                self.itemsViewController.tableView.stopFooterLoading()
        }
    }

    // MARK: - Objc

    @objc private func didPullToRefresh() {
        setInitialItems()
    }
}

// MARK: - Storyboardable

extension StockViewController: Storyboardable {

    func inject(_ dependency: StockRepository) {
        self.stockRepository = dependency
        self.itemsViewController = ItemsViewController(with: nil)
    }
}

// MARK: - ItemsViewControllerDelegate

extension StockViewController: ItemsViewControllerDelegate {

    func itemsViewControllerDidReload(_ itemsViewController: ItemsViewController) {
        setInitialItems()
    }

    func itemsViewControllerDidReachButtom(_ itemsViewController: ItemsViewController) {
        setMoreItems(page: nextPage)
    }
}
