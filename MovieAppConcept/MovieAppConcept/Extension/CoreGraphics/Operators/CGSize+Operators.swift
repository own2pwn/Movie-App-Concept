//
//  CGSize+Operators.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 08.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

public extension CGSize {
    public var center: CGPoint {
        return CGPoint(x: width / 2, y: height / 2)
    }

    public static func -(_ lhs: CGSize, _ rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }
}
