//
//  CAShapeLayer+Animation.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 04.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

public extension CAShapeLayer {

    // MARK: -  Animations
    
    public static var animationDuration: CFTimeInterval = 0.25
    
    public func animateFill(_ startColor: UIColor, _ endColor: UIColor, with duration: CFTimeInterval = CAShapeLayer.animationDuration) {
        let keyPath = "fillColor"
        let fillAnimation = CABasicAnimation(keyPath: keyPath)
        
        fillAnimation.fromValue = startColor.cgColor
        fillAnimation.toValue = endColor.cgColor
        fillAnimation.duration = duration
        fillAnimation.fillMode = kCAFillModeBoth // kCAFillModeForwards
        
        fillColor = endColor.cgColor
        add(fillAnimation, forKey: keyPath)
    }
    
    public func animateScale(fromValue: CGFloat, toValue: CGFloat, autorevese: Bool = true, repeats: Float = 1, with duration: CFTimeInterval = CAShapeLayer.animationDuration) {
        let keyPath = "transform.scale"
        let scaleAnimation: CABasicAnimation = CABasicAnimation(keyPath: keyPath)
        
        scaleAnimation.duration = duration
        scaleAnimation.fromValue = fromValue
        scaleAnimation.toValue = toValue
        scaleAnimation.autoreverses = autorevese
        scaleAnimation.repeatCount = repeats
        
        add(scaleAnimation, forKey: keyPath)
    }
}
