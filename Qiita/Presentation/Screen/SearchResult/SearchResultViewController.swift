//
//  SearchResultViewController.swift
//  Qiita
//
//  Created by kntk on 2019/10/24.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture

final class SearchResultViewController: UIViewController {

    // MARK: - Outlet

    @IBOutlet private var emptyView: UIView!
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    @IBOutlet private weak var containerView: UIView!

    // MARK: - Property

    private var itemsViewController: ItemsViewController! {
        didSet {
            itemsViewController.delegate = self
        }
    }
    private var itemService: ItemService!

    private var isLoading = false
    private var searchType: SearchType!
    private var nextPage = 2

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(itemsViewController, to: containerView)
        fd_prefersNavigationBarHidden = true
        setupUI()
        setInitialItems()
    }

    // MARK: - Private

    private func setupUI() {
        switch searchType {
        case .tag(let tag):
            navigationBarItem.title = "タグ: \(tag.id)"

        case .word(let word):
            navigationBarItem.title = "キーワード: \(word)"

        default:
            break
        }
    }

    private func setInitialItems() {
        if isLoading { return }
        isLoading = true
        itemService.getItems(with: searchType, page: 1)
            .done { items in
                if items.isEmpty {
                    self.itemsViewController.showEmptyView(view: self.emptyView)
                } else if case .word = self.searchType {
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

    // MARK: - Action

    @IBAction private func backButtonDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Storyboardable

extension SearchResultViewController: Storyboardable {

    func inject(_ dependency: SearchType) {
        self.searchType = dependency
        self.itemService = ItemService()

        var headerView: TagHeaderView? = nil
        if case .tag(let tag) = dependency {
            headerView = TagHeaderView(with: tag)
        }
        self.itemsViewController = ItemsViewController(with: headerView)
    }
}

// MARK: - ItemsViewControllerDelegate

extension SearchResultViewController: ItemsViewControllerDelegate {

    func itemsViewControllerDidReload(_ itemsViewController: ItemsViewController) {
        setInitialItems()
    }

    func itemsViewControllerDidReachButtom(_ itemsViewController: ItemsViewController) {
        setMoreItems(page: nextPage)
    }
}
