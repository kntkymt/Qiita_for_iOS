//
//  CollectionSection.swift
//  Qiita
//
//  Created by kntk on 2019/10/01.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit

protocol CollectionSection {

    var numberOfItems: Int { get }
    func layoutSection(based view: UIView) -> NSCollectionLayoutSection
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}
