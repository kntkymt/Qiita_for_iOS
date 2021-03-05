//
//  ItemViewController.swift
//  Qiita
//
//  Created by kntk on 2019/09/28.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture
import Floaty

final class ItemViewController: UIViewController {

    // MARK: - Outlet

    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var titleLabel: UINavigationItem! {
        didSet {
            titleLabel.title = item.title
        }
    }
    @IBOutlet private weak var floatingButton: Floaty! {
        didSet {
            guard Auth.shared.isSignedin else {
                floatingButton.isHidden = true
                return
            }

            stockRepository.checkIsStocked(id: item.id)
                .done { _ in
                    self.floatingButton.addItem("ストック済み", icon: UIImage(systemName: "folder.fill"), handler: { [unowned self] item in
                        self.unstockButtonAction(item: item)
                    })
                }.catch { _ in
                    self.floatingButton.addItem("ストックする", icon: UIImage(systemName: "folder"), handler: { [unowned self] item in
                        self.stockButtonAction(item: item)
                    })
                }

            likeRepository.checkIsLiked(id: item.id)
                .done { _ in
                    self.floatingButton.addItem("いいね済み", icon: UIImage(systemName: "hand.thumbsup.fill"), handler: { [unowned self] item in
                        self.unlikeButtonAction(item: item)
                    })
                }.catch { _ in
                    self.floatingButton.addItem("いいねする", icon: UIImage(systemName: "hand.thumbsup"), handler: { [unowned self] item in
                        self.likeButtonAction(item: item)
                    })
                }
        }
    }

    // MARK: - Property

    private var item: Item!

    private var stockRepository: StockRepository!
    private var likeRepository: LikeRepository!
    private let webView = WKWebViewWarmupper.shared.getView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private

    private func setupUI() {
        fd_prefersNavigationBarHidden = true

        webView.load(URLRequest(url: item.url))
        view.insertSubview(webView, at: 0)

        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func stockButtonAction(item: FloatyItem) {
        stockRepository.stock(id: self.item.id)
            .done { _ in
                item.title = "ストック済み"
                item.icon = UIImage(systemName: "folder.fill")
                item.handler = { [unowned self] item in
                    self.unstockButtonAction(item: item)
                }
                self.floatingButton.close()
            }.catch { error in
                Logger.error(error)
            }
    }

    private func unstockButtonAction(item: FloatyItem) {
        stockRepository.unstock(id: self.item.id)
            .done { _ in
                item.title = "ストックする"
                item.icon = UIImage(systemName: "folder")
                item.handler = { [unowned self] item in
                    self.stockButtonAction(item: item)
                }
                self.floatingButton.close()
            }.catch { error in
                Logger.error(error)
            }
    }

    private func likeButtonAction(item: FloatyItem) {
        likeRepository.like(id: self.item.id)
            .done { _ in
                item.title = "いいね済み"
                item.icon = UIImage(systemName: "hand.thumbsup.fill")
                item.handler = { [unowned self] item in
                    self.unlikeButtonAction(item: item)
                }
                self.floatingButton.close()
            }.catch { error in
                Logger.error(error)
            }
    }

    private func unlikeButtonAction(item: FloatyItem) {
        likeRepository.unlike(id: self.item.id)
            .done { _ in
                item.title = "いいねする"
                item.icon = UIImage(systemName: "hand.thumbsup")
                item.handler = { [unowned self] item in
                    self.likeButtonAction(item: item)
                }
                self.floatingButton.close()
            }.catch { error in
                Logger.error(error)
            }
    }

    // MARK: - Action

    @IBAction private func backButtonDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Storyboardable

extension ItemViewController: Storyboardable {

    func inject(_ dependency: (item: Item, stockRepository: StockRepository, likeRepository: LikeRepository)) {
        self.stockRepository = dependency.stockRepository
        self.likeRepository = dependency.likeRepository
        self.item = dependency.item
    }
}
