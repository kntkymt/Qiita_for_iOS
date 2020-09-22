//
//  UITableView+.swift
//  Qiita
//
//  Created by kntk on 2019/09/28.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit
import ReusableKit
import Instantiate

extension UITableView {

    func dequeue<Cell: Instantiate.Injectable>(_ cell: ReusableCell<Cell>, for indexPath: IndexPath, with dependency: Cell.Dependency) -> Cell {
        let cell = dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as! Cell // swiftlint:disable:this force_cast
        cell.inject(dependency)
        return cell
    }

    func startFooterLoading() {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.color = .systemGray
        indicatorView.backgroundColor = .systemBackground
        indicatorView.frame.size.height = 50
        indicatorView.isHidden = false
        self.tableFooterView = indicatorView
        indicatorView.startAnimating()
    }

    func stopFooterLoading() {
        self.tableFooterView = nil
    }

    func scrollToTop(animated: Bool = true) {
        let indexPath = IndexPath(row: 0, section: 0)
        scrollToRow(at: indexPath, at: .top, animated: animated)
    }
}
