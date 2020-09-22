//
//  ProfileViewController.swift
//  Qiita
//
//  Created by kntk on 2019/10/12.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture
import ReusableKit

final class ProfileViewController: UIViewController {

    enum Reusable {
        static let cell = ReusableCell<ItemTableViewCell>(nibName: "ItemTableViewCell")
    }

    // MARK: - Outlet

    // FIXME: IBDesignable使いたい
    @IBOutlet private weak var profileHeaderView: UIView!
    @IBOutlet private weak var emptyView: UIView!
    @IBOutlet private weak var containerView: UIView!

    // MARK: - Property

    private var itemsViewController: ItemsViewController! {
        didSet {
            itemsViewController.delegate = self
        }
    }

    private var itemService: ItemService!

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
        setProfile()
        setInitialItems()
    }

    // MARK: - Private

    private func showReccomendSignInView() {
        let reccomendView = ReccomendSignInView(with: ())
        view.addSubview(reccomendView)
        reccomendView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reccomendView.topAnchor.constraint(equalTo: profileHeaderView.topAnchor),
            reccomendView.leftAnchor.constraint(equalTo: view.leftAnchor),
            reccomendView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            reccomendView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func setProfile() {
        Auth.shared.currentUser
            .done { user in
                let profileContent = UserHeaderView(with: user)
                self.profileHeaderView.addSubview(profileContent)
                profileContent.makeEdgesEqualToSuperView()
            }.catch { error in
                Logger.error(error)
            }
    }

    private func setInitialItems() {
        if isLoading { return }
        isLoading = true
        itemService.getAuthenticatedUserItems(page: 1)
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
        itemsViewController.tableView.startFooterLoading()
        itemService.getAuthenticatedUserItems(page: nextPage)
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

    // MARK: - Action

    @IBAction private func settingButtonDidTap(_ sender: Any) {
        let viewController = SettingViewController(with: ())
        present(viewController, animated: true)
    }
}

// MARK: - Storyboardable

extension ProfileViewController: Storyboardable {

    func inject(_ dependency: ()) {
        self.itemService = ItemService()
        self.itemsViewController = ItemsViewController(with: nil)
    }
}

// MARK: - ItemsViewControllerDelegate

extension ProfileViewController: ItemsViewControllerDelegate {

    func itemsViewControllerDidReload(_ itemsViewController: ItemsViewController) {
        setInitialItems()
    }

    func itemsViewControllerDidReachButtom(_ itemsViewController: ItemsViewController) {
        setMoreItems(page: nextPage)
    }
}
