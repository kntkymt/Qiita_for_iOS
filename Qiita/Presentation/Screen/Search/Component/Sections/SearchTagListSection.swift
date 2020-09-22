//
//  SearchTagListSection.swift
//  Qiita
//
//  Created by kntk on 2019/10/01.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit

struct SearchTagListSection: CollectionSection {

    typealias Cell = SearchTagCell

    // MARK: - Property

    var numberOfItems: Int {
        fatalError()
    }

    // MARK: - Public

    func layoutSection(based view: UIView) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute((view.frame.width - 2) / 3), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1 / 3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(1)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 1
        return section
    }

    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        fatalError()
    }
}
