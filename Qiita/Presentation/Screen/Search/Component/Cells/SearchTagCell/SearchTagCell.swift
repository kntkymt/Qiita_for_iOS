//
//  SearchTagCell.swift
//  Qiita
//
//  Created by kntk on 2019/10/01.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit
import Instantiate

final class SearchTagCell: UICollectionViewCell {

    // MARK: - Outlet
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var wordLabel: UILabel!

    // MARK: - Property

    private var searchTag: ItemTag! {
        didSet {
            imageView.load(searchTag.iconUrl, placeholder: #imageLiteral(resourceName: "Image"))
            wordLabel.text = searchTag.id
        }
    }
}

// MARK: - NibInstantiatable

extension SearchTagCell: NibInstantiatable {

    func inject(_ dependency: ItemTag) {
        self.searchTag = dependency
    }
}
