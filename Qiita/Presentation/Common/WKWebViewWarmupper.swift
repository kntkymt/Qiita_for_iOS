//
//  WKWebViewWarmupper.swift
//  Qiita
//
//  Created by kntk on 2019/09/28.
//  Copyright © 2019 kntk. All rights reserved.
//

import WebKit
import WebViewWarmupper

final class WKWebViewWarmupper: ViewWarmupper<WKWebView> {

    static let shared = WKWebViewWarmupper()

    private static let sharedConfig: WKWebViewConfiguration = {
        let userContentController = WKUserContentController()
        let fileName = "WebViewRuleList.json"

        if let jsonFilePath = Bundle.main.path(forResource: fileName, ofType: nil),
            let jsonFileContent = try? String(contentsOfFile: jsonFilePath, encoding: String.Encoding.utf8) {
            WKContentRuleListStore.default().compileContentRuleList(forIdentifier: "qiita", encodedContentRuleList: jsonFileContent) { contentRuleList, error in
                if let error = error {
                    Logger.error(error)
                    return
                }
                if let list = contentRuleList {
                    userContentController.add(list)
                }
            }
        }

        let config = WKWebViewConfiguration()
        config.userContentController = userContentController
        config.websiteDataStore = .default()

        return config
    }()

    init() {
        super.init(maxSize: 3) {
            let webView = WKWebView(frame: .zero, configuration: WKWebViewWarmupper.sharedConfig)

            return webView
        }
    }

    override func getView() -> WKWebView {
        let webView = super.getView()

        return webView
    }
}
