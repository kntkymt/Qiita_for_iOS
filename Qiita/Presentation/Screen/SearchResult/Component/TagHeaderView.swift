//
//  TagHeaderView.swift
//  Qiita
//
//  Created by kntk on 2019/10/12.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit

final class TagHeaderView: UIView {

    // MARK: - Outlet

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var tagTitleLabel: UILabel!
    @IBOutlet private weak var itemsCountLabel: UILabel!
    @IBOutlet private weak var followersCountLabel: UILabel!
    @IBOutlet private weak var followButton: ToggleButton!

    // MARK: - Property

    private var tagRepository: TagRepository!

    private var itemTag: ItemTag! {
        didSet {
            iconImageView.load(itemTag.iconUrl)
            tagTitleLabel.text = itemTag.id
            itemsCountLabel.text = "\(itemTag.itemsCount)"
            followersCountLabel.text = "\(itemTag.followersCount)"

            guard Auth.shared.isSignedin else {
                followButton.isHidden = true
                return
            }
            tagRepository.checkIsFollowed(id: itemTag.id)
                .done { _ in
                    self.followButton.isToggled = true
                }.catch { _ in
                    self.followButton.isToggled = false
                }
        }
    }

    // MARK: - Action

    @IBAction private func followButtonDidTap(_ sender: Any) {
        followButton.isToggled.toggle()
        (followButton.isToggled ? tagRepository.follow(id: itemTag.id) : tagRepository.unfollow(id: itemTag.id))
            .done { _ in
            }.catch { error in
                Logger.error(error)
            }
    }
}

// MARK: - NibInstantiatable

extension TagHeaderView: NibInstantiatable {

    func inject(_ dependency: (itemTag: ItemTag, tagRepository: TagRepository)) {
        self.tagRepository = dependency.tagRepository
        self.itemTag = dependency.itemTag
    }
}
