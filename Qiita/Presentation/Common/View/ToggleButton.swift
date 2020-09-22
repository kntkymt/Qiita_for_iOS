//
//  ToggleButton.swift
//  Qiita
//
//  Created by kntk on 2019/10/27.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit

@IBDesignable class ToggleButton: UIButton {

    @IBInspectable var unToggleImage: UIImage? {
        didSet { setImage() }
    }

    @IBInspectable var toggleImage: UIImage? {
        didSet { setImage() }
    }

    @IBInspectable var unToggleTitle: String? {
        didSet { setTitle() }
    }

    @IBInspectable var toggleTitle: String? {
        didSet { setTitle() }
    }

    var isToggled = false {
        didSet {
            setImage()
            setTitle()
        }
    }

    private func setImage() {
        isToggled ? setImage(toggleImage, for: .normal) : setImage(unToggleImage, for: .normal)
    }

    private func setTitle() {
        isToggled ? setTitle(toggleTitle, for: .normal) :
            setTitle(unToggleTitle, for: .normal)
    }
}
