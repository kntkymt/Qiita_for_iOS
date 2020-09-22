//
//  NSObject+.swift
//  Qiita
//
//  Created by kntk on 2019/09/23.
//  Copyright © 2019 kntk. All rights reserved.
//

import Foundation

extension NSObject {

    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}
