//
//  Auth.swift
//  Qiita
//
//  Created by kntk on 2019/10/13.
//  Copyright © 2019 kntk. All rights reserved.
//

import SafariServices
import PromiseKit

final class Auth {

    // MARK: - Static

    static let shared = Auth()

    // MARK: - Property

    private var observer: (promise: Promise<AuthModel>, resolver: Resolver<AuthModel>)!

    private lazy var viewController: SFSafariViewController = {
        let url = URL(string: AppConstant.Auth.baseURL)!
            .addQuery(name: "scope", value: AppConstant.Auth.scope)!
            .addQuery(name: "client_id", value: AppConstant.Auth.clientId)!

        let viewController = SFSafariViewController(url: url)
        viewController.modalPresentationStyle = .automatic

        return viewController
    }()

    @KeyChain(key: "accessToken")
    var accessToken: String?

    var isSignedin: Bool {
        return accessToken != nil
    }

    var currentUser: Promise<User> {
        return API.shared.call(AuthTarget.getAccount)
    }

    // MARK: - Public

    func handleDeepLink(url: URL) {
        viewController.bottomPresentingViewController().dismiss(animated: true)
        let parameters = url.queryParameters
        guard let code = parameters["code"] else {
            observer.resolver.reject(NetworkingError.internal(message: "there is no parameter named code in this deeplink"))
            return
        }

        API.shared.call(AuthTarget.getAccessToken(code: code))
            .done { (auth: AuthModel) in
                self.accessToken = auth.token
                self.observer.resolver.fulfill(auth)
            }.catch { error in
                self.observer.resolver.reject(error)
            }
    }

    func signin() -> Promise<AuthModel> {
        observer = Promise<AuthModel>.pending()

        SceneRouter.shared.rootViewController.currentViewController?.topPresentedViewController().present(viewController, animated: true)

        return observer.promise
    }

    func signout() -> Promise<Void> {
        let result: Promise<VoidModel> = API.shared.call(AuthTarget.deleteAccessToken(accessToken: accessToken ?? "accessToken not found"))

        return result.map { _ in self.accessToken = nil }
    }

    // MARK: - Initializer

    private init() {
    }
}
