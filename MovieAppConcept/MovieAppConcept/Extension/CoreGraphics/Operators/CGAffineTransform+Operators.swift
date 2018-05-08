//
//  CGAffineTransform+Operators.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 08.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

public extension CGAffineTransform {
    public static func +(_ lhs: CGAffineTransform, _ rhs: CGAffineTransform) -> CGAffineTransform {
        return CGAffineTransform(a: lhs.a + rhs.a, b: lhs.b + rhs.b, c: lhs.c + rhs.c,
                                 d: lhs.d + rhs.d, tx: lhs.tx + rhs.tx, ty: lhs.ty + rhs.ty)
    }
    
    public static func -(_ lhs: CGAffineTransform, _ rhs: CGAffineTransform) -> CGAffineTransform {
        return CGAffineTransform(a: lhs.a - rhs.a, b: lhs.b - rhs.b, c: lhs.c - rhs.c,
                                 d: lhs.d - rhs.d, tx: lhs.tx - rhs.tx, ty: lhs.ty - rhs.ty)
    }
    
    public static func *(_ lhs: CGAffineTransform, _ rhs: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(a: lhs.a * rhs, b: lhs.b * rhs, c: lhs.c * rhs,
                                 d: lhs.d * rhs, tx: lhs.tx * rhs, ty: lhs.ty * rhs)
    }
    
    public func rightBound(to value: CGAffineTransform) -> CGAffineTransform {
        return CGAffineTransform(a: a.rightBound(to: value.a), b: b.rightBound(to: value.b),
                                 c: c.rightBound(to: value.c), d: d.rightBound(to: value.d),
                                 tx: tx.rightBound(to: value.tx), ty: ty.rightBound(to: value.ty))
    }
}
