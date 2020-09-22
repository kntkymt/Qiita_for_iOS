//
//  TItleCell.swift
//  Qiita
//
//  Created by kntk on 2019/10/01.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit
import Instantiate

final class TitleCell: UICollectionViewCell {

    // MARK: - Outlet

    @IBOutlet private weak var titleLabel: UILabel!

    // MARK: - Property

    private var title: String! {
        didSet {
            titleLabel.text = title
        }
    }
}

// MARK: - NibInstantiatable

extension TitleCell: NibInstantiatable {

    func inject(_ dependency: String) {
        self.title = dependency
    }
}
