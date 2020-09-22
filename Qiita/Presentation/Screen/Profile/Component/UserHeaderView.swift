//
//  UserHeaderView.swift
//  Qiita
//
//  Created by kntk on 2019/10/19.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit

final class UserHeaderView: UIView {

    // MARK: - Outlet

    @IBOutlet private weak var iconImageView: RoundedImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userIdLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    @IBOutlet private weak var itemsCountLabel: UILabel!
    @IBOutlet private weak var followeesCountLabel: UILabel!
    @IBOutlet private weak var followersCountLabel: UILabel!

    // MARK: - Property

    private var user: User! {
        didSet {
            iconImageView.load(user.profileImageUrl)
            userNameLabel.text = user.name
            userIdLabel.text = "@\(user.id)"
            descriptionLabel.text = user.description
            itemsCountLabel.text = "\(user.itemsCount)"
            followeesCountLabel.text = "\(user.followeesCount)"
            followersCountLabel.text = "\(user.followersCount)"
        }
    }
}

// MARK: - NibInstantiatable

extension UserHeaderView: NibInstantiatable {

    func inject(_ dependency: User) {
        self.user = dependency
    }
}
