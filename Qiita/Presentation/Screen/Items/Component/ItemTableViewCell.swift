//
//  ItemTableViewCell.swift
//  Qiita
//
//  Created by kntk on 2019/09/29.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit

final class ItemTableViewCell: UITableViewCell {

    // MARK: - Outlet

    @IBOutlet private weak var autherIconImageView: RoundedImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var autherLabel: UILabel!
    @IBOutlet private weak var createdLabel: UILabel!
    @IBOutlet private weak var likesCountLabel: UILabel!
    @IBOutlet private weak var stockButton: ToggleButton!

    // MARK: - Property

    private var stockService: StockService!

    private var item: Item! {
        didSet {
            autherIconImageView.load(item.user.profileImageUrl, placeholder: #imageLiteral(resourceName: "Image"))
            titleLabel.text = item.title
            autherLabel.text = "by " + (item.user.name.isEmpty ? item.user.id : item.user.name)
            createdLabel.text = item.createdAt.offsetFrom()
            likesCountLabel.text = "\(item.likesCount)"

            guard Auth.shared.isSignedin else {
                stockButton.isHidden = true
                return
            }
            stockService.checkIsStocked(id: item.id)
                .done { _ in
                    self.stockButton.isToggled = true
                }.catch { _ in
                    self.stockButton.isToggled = false
                }
        }
    }

    // MARK: - Action

    @IBAction private func stockButtonDidTap(_ sender: Any) {
        stockButton.isToggled.toggle()
        (stockButton.isToggled ? stockService.stock(id: item.id) : stockService.unstock(id: item.id))
            .done { _ in

            }.catch { error in
                Logger.error(error)
            }
    }
}

// MARK: - NibInstantiatable

extension ItemTableViewCell: NibInstantiatable {

    func inject(_ dependency: Item) {
        self.stockService = StockService()
        self.item = dependency
    }
}
