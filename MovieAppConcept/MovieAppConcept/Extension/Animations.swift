//
//  Animations.swift
//  EPButton-T
//
//  Created by Evgeniy on 30.03.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

typealias VoidBlock = () -> Void

extension UIView {
    static func animate(_ block: @escaping VoidBlock) {
        UIView.animate(withDuration: 0.3, animations: block)
    }

    static func animate(_ duration: TimeInterval, _ block: @escaping VoidBlock) {
        UIView.animate(withDuration: duration, animations: block)
    }
}
