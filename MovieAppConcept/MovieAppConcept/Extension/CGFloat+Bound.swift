//
//  CGFloat+Bound.swift
//  EPTag-T
//
//  Created by Evgeniy on 14.04.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import CoreGraphics

public extension CGFloat {

    // MARK: - Interval

    public func bound(min: CGFloat, _ max: CGFloat) -> CGFloat {
        return self < min ? min : self > max ? max : self
    }

    // MARK: - Left Bounds

    public mutating func leftBounded(to value: CGFloat) {
        if self < value {
            self = value
        }
    }

    public func leftBound(to value: CGFloat) -> CGFloat {
        return self < value ? value : self
    }

    // MARK: - Right Bounds

    public mutating func rightBounded(to value: CGFloat) {
        if self > value {
            self = value
        }
    }

    public func rightBound(to value: CGFloat) -> CGFloat {
        return self > value ? value : self
    }
}
