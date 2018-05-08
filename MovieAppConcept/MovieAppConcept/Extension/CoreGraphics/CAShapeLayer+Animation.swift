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
    
    public func animateFill(_ startColor: UIColor, _ endColor: UIColor, duration: CFTimeInterval = CAShapeLayer.animationDuration) {
        let kp = "fillColor"
        let fillAnimation = CABasicAnimation(keyPath: kp)
        
        fillAnimation.fromValue = startColor.cgColor
        fillAnimation.toValue = endColor.cgColor
        fillAnimation.duration = duration
        fillAnimation.fillMode = kCAFillModeBoth // kCAFillModeForwards
        
        fillColor = endColor.cgColor
        add(fillAnimation, forKey: kp)
    }
    
    public func animateOpacity(fromValue: CGFloat = 0, toValue: CGFloat = 1, duration: CFTimeInterval = CAShapeLayer.animationDuration) {
        let kp = "opacity"
        let opacityAnimation = CABasicAnimation(keyPath: kp)
        opacityAnimation.fromValue = fromValue
        opacityAnimation.toValue = toValue
        opacityAnimation.duration = 0.3
        add(opacityAnimation, forKey: kp)
    }
    
    public func animateScale(fromValue: CGFloat, toValue: CGFloat, autoreverse: Bool = true, repeats: Float = 1, duration: CFTimeInterval = CAShapeLayer.animationDuration) {
        let kp = "transform.scale"
        let scaleAnimation: CABasicAnimation = CABasicAnimation(keyPath: kp)
        
        scaleAnimation.duration = duration
        scaleAnimation.fromValue = fromValue
        scaleAnimation.toValue = toValue
        scaleAnimation.autoreverses = autoreverse
        scaleAnimation.repeatCount = repeats
        
        add(scaleAnimation, forKey: kp)
    }
}
