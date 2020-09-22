//
//  RefreshControll.swift
//  Qiita
//
//  Created by kntk on 2019/09/28.
//  Copyright © 2019 kntk. All rights reserved.
//

import UIKit

final class RefreshControl: UIRefreshControl {

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.zPosition = -999
    }

    override convenience init() {
        self.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func didMoveToSuperview() {
        swizzle()
        super.didMoveToSuperview()
        if let scrollView = self.superview as? UIScrollView {
            self.tintColor = self.tintColor ?? UIRefreshControl.appearance().tintColor
            scrollView.contentOffset.y = -self.frame.height
        }
    }

    // MARK: - Private

    private func swizzle() {
        method_exchangeImplementations(
            class_getInstanceMethod(RefreshControl.self, NSSelectorFromString("_scrollViewHeight"))!,
            class_getInstanceMethod(RefreshControl.self, NSSelectorFromString("ss_scrollViewHeight"))!
        )
    }

    @objc private func ss_scrollViewHeight() -> CGFloat {
        return 0
    }
}
