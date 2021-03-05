//
//  AppContainer.swift
//  Qiita
//
//  Created by kntk on 2021/03/05.
//  Copyright © 2021 kntk. All rights reserved.
//

import Foundation

final class AppContainer {

    // MARK: - Static

    static let shared = AppContainer()

    // MARK: - Property

    let itemRepository: ItemRepository
    let tagRepository: TagRepository
    let stockRepository: StockRepository
    let userRepository: UserRepository
    let likeRepository: LikeRepository
    let authRepository: AuthRepository

    // MARK: - Private

    private init() {
        switch AppEnvironment.shared.buildConfig {
        case .debug, .release:
            itemRepository = ItemService()
            tagRepository = TagService()
            stockRepository = StockService()
            userRepository = UserService()
            likeRepository = LikeService()
            authRepository = AuthService()
        }
    }
}
