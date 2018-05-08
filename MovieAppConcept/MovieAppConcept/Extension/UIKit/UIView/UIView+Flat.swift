//
//  UIView+Flat.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 08.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

public extension UIView {
    public func makeFlat(with radius: CGFloat = 8) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}
