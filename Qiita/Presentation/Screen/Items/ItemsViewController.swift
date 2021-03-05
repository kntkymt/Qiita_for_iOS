//
//  ItemsViewController.swift
//  Qiita
//
//  Created by kntk on 2019/09/28.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit
import ReusableKit

protocol ItemsViewControllerDelegate: class {
    func itemsViewControllerDidReachButtom(_ itemsViewController: ItemsViewController)
    func itemsViewControllerDidReload(_ itemsViewController: ItemsViewController)
}

final class ItemsViewController: UIViewController {

    enum Reusable {
        static let cell = ReusableCell<ItemTableViewCell>(nibName: "ItemTableViewCell")
    }

    // MARK: - Outlet

    @IBOutlet private(set) weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.refreshControl = refreshControl
            tableView.register(Reusable.cell)
        }
    }

    // MARK: - Property

    var items: [Item] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    weak var delegate: ItemsViewControllerDelegate?

    private var headerView: UIView?

    private(set) lazy var refreshControl: RefreshControl = {
        let refreshControl = RefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)

        return refreshControl
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fd_prefersNavigationBarHidden = true
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleHeight = scrollView.frame.height - scrollView.contentInset.top - scrollView.contentInset.bottom
        let y = scrollView.contentOffset.y + scrollView.contentInset.top
        let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)

        if y > threshold {
            delegate?.itemsViewControllerDidReachButtom(self)
        }
    }

    // MARK: - Public

    func showEmptyView(view: UIView) {
        view.frame.size = CGSize(width: tableView.frame.width, height: tableView.frame.height - 88)
        headerView = view
        tableView.reloadData()
    }

    func hideEmptyView() {
        headerView = nil
        tableView.reloadData()
    }

    // MARK: - Objc

    @objc private func didPullToRefresh() {
        delegate?.itemsViewControllerDidReload(self)
    }
}

// MARK: - Storyboardable

extension ItemsViewController: Storyboardable {

    func inject(_ dependency: UIView? = nil) {
        self.headerView = dependency
    }
}

// MARK: - UITableViewDataSource

extension ItemsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(Reusable.cell, for: indexPath, with: (item: items[indexPath.row], stockRepository: AppContainer.shared.stockRepository))

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
}

// MARK: - UITableViewDelegate

extension ItemsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ItemViewController(with: items[indexPath.row])
        navigationController?.pushViewController(viewController, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let headerView = headerView else { return .zero }
        
        return headerView.frame.height
    }
}
