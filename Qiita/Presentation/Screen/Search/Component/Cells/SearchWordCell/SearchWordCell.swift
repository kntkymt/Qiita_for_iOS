//
//  SearchWordCell.swift
//  Qiita
//
//  Created by kntk on 2019/10/05.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit
import Instantiate

final class SearchWordCell: UICollectionViewCell {

    // MARK: - Outlet

    @IBOutlet private weak var titleLabel: UILabel!

    // MARK: - Property

    private var title: String! {
        didSet {
            contentView.layer.cornerRadius = 14
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = UIColor(named: "Brand")?.cgColor
            titleLabel.textColor = UIColor(named: "Brand")
            titleLabel.text = title
        }
    }
}

// MARK: - NibInstantiatable

extension SearchWordCell: NibInstantiatable {

    func inject(_ dependency: String) {
        self.title = dependency
    }
}
