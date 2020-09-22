//
//  Storyboardable.swift
//  Qiita
//
//  Created by kntk on 2019/09/23.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit
import Instantiate

typealias Storyboardable = StoryboardInstantiatable

extension Storyboardable where Self: UIViewController {
    
    static var storyboardName: StoryboardName {
        return className.replacingOccurrences(of: "ViewController", with: "")
    }
}
