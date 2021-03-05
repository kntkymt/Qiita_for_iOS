//
//  SettingTableViewController.swift
//  Qiita
//
//  Created by kntk on 2019/10/21.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit

final class SettingTableViewController: UITableViewController, AlertShowable {

    // MARK: - Property

    private let authRepository: AuthRepository = AppContainer.shared.authRepository

    // MARK: - Outlet

    @IBOutlet private weak var signActionLabel: UILabel! {
        didSet {
            if !authRepository.isSignedin {
                signActionLabel.text = "ログイン"
                signActionLabel.textColor = UIColor(named: "Brand")
            }
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.indexPathsForSelectedRows?.forEach {
            tableView.deselectRow(at: $0, animated: true)
        }
        
        guard authRepository.isSignedin else {
            authRepository.signin()
                .done { _ in
                    SceneRouter.shared.route(to: .splash, animated: true)
                }.catch { error in
                    Logger.error(error)
                }
            return
        }

        showAlert(title: "確認", message: "ログアウトしてよろしいですか?") {
            self.authRepository.signout()
                .done { _ in
                    AppContext.isFirstLaunch = true
                    self.dismiss(animated: true)
                    SceneRouter.shared.route(to: .login, animated: true)
                }.catch { error in
                    Logger.error(error)
                }
        }
    }
}

// MARK: - Storyboardable

extension SettingTableViewController: Storyboardable {

    func inject(_ dependency: ()) {
    }
}
