//
//  EPNavigationController.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 09.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

final class EPNavigationController: UINavigationController {

    // MARK: - Overrides

    /// Respects childs status bar style.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }

    /// Respects childs status bar style.
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)

        setNeedsStatusBarAppearanceUpdate()
    }
}
