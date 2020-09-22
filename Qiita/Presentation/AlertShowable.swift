//
//  AlertShowable.swift
//  Qiita
//
//  Created by kntk on 2019/10/21.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit

protocol AlertShowable: class {
}

extension AlertShowable where Self: UIViewController {

    func showAlert(title: String, message: String?, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
