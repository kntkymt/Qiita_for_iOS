//
//  NibInstantintiatable.swift
//  Qiita
//
//  Created by kntk on 2019/10/19.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit
import Instantiate

typealias NibInstantiatable = Instantiate.NibInstantiatable

extension NibInstantiatable where Self: UIView {

    public static var nibName: NibName {
        return className
    }
}
