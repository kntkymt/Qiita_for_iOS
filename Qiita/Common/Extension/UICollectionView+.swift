//
//  UICollectionView+.swift
//  Qiita
//
//  Created by kntk on 2019/10/22.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit
import Instantiate
import ReusableKit

extension UICollectionView {

    func dequeue<Cell: Instantiate.Injectable>(_ cell: ReusableCell<Cell>, for indexPath: IndexPath, with dependency: Cell.Dependency) -> Cell {
        let cell = dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as! Cell // swiftlint:disable:this force_cast
        cell.inject(dependency)
        return cell
    }
}
