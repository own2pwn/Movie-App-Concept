//
//  CGRect+Operators.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 08.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

public extension CGRect {
    //    public var center: CGPoint {
    //        return CGPoint(x: width / 2, y: height / 2)
    //    }

    public static func -(_ lhs: CGRect, _ rhs: CGRect) -> CGRect {
        let newOrigin = lhs.origin - rhs.origin
        let newSize = lhs.size - rhs.size

        return CGRect(origin: newOrigin, size: newSize)
    }

    public var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}
