//
//  UIView+Separator.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 03.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

public enum SeparatorPosition {
    case top, bot
}

public extension UIView {
    public func addHorizontalSeparator(at position: SeparatorPosition, margin: CGFloat, color: UIColor) {
        let separatorLayer = CALayer()
        let mySize = bounds.size

        let yPosition: CGFloat = position == .top ? 0 : mySize.height
        let origin = CGPoint(x: margin, y: yPosition)

        separatorLayer.frame = CGRect(origin: origin, size: CGSize(width: mySize.width - 2 * margin, height: 1))
        separatorLayer.backgroundColor = color.cgColor

        layer.addSublayer(separatorLayer)
    }
}
