//
//  RoundedImageView.swift
//  Qiita
//
//  Created by kntk on 2019/09/29.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit

@IBDesignable final class RoundedImageView: UIImageView {

    // MARK: - Property

    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            updateProperties()
        }
    }

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        updateProperties()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateProperties()
    }

    // MARK: - Property

    private func updateProperties() {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
    }
}
