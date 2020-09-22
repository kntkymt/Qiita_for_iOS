//
//  SettingViewController.swift
//  Qiita
//
//  Created by kntk on 2019/09/28.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit

final class SettingViewController: UIViewController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func closeButtonDidTap(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: - Storyboardable

extension SettingViewController: Storyboardable {

    func inject(_ dependency: ()) {
    }
}
