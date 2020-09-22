//
//  SearchWordsSection.swift
//  Qiita
//
//  Created by kntk on 2019/10/05.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit
import ReusableKit

struct SearchWordsSection: CollectionSection {

    // MARK: - Property

    var numberOfItems: Int {
        return words.count
    }

    let words: [String]

    // MARK: - Public

    func layoutSection(based view: UIView) -> NSCollectionLayoutSection {
        let items: [NSCollectionLayoutItem] = words.map { title in
            let size = NSCollectionLayoutSize(widthDimension: .absolute(CGFloat(title.count * 8) + 32), heightDimension: .absolute(27))
            return NSCollectionLayoutItem(layoutSize: size)
        }

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(29 + 8))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: items)
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(8)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0)

        let section = NSCollectionLayoutSection(group: group)
        return section
    }

    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(SearchViewController.Reusable.searchWordCell, for: indexPath, with: words[indexPath.row])

        return cell
    }
}
