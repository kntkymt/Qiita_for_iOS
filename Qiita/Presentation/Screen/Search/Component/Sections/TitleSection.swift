//
//  TitleSection.swift
//  Qiita
//
//  Created by kntk on 2019/10/03.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit
import ReusableKit

struct TitleSection: CollectionSection {

    typealias Cell = TitleCell

    // MARK: - Property

    let numberOfItems = 1
    let title: String

    // MARK: - Public

    func layoutSection(based view: UIView) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        return section
    }

    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(SearchViewController.Reusable.titleCell, for: indexPath, with: title)

        return cell
    }
}
