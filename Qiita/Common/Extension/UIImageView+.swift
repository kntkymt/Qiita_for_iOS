//
//  UIImageView+.swift
//  Qiita
//
//  Created by kntk on 2019/09/29.
//  Copyright © 2019 kntk. All rights reserved.
//

import Foundation
import UIKit
import Nuke

extension UIImageView {

    func load(_ url: URL?, placeholder: Image? = nil, contentMode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = url else { return }
        
        let contentModes = ImageLoadingOptions.ContentModes(success: contentMode, failure: contentMode, placeholder: contentMode)
        let options: ImageLoadingOptions = {
            if let placeholder = placeholder {
                return ImageLoadingOptions(placeholder: placeholder, contentModes: contentModes)
            } else {
                return ImageLoadingOptions(contentModes: contentModes)
            }
        }()
        Nuke.loadImage(with: url, options: options, into: self)
    }
}
