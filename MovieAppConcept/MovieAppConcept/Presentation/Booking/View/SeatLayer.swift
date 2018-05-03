//
//  SeatLayer.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 03.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

public final class SeatLayer: CAShapeLayer {

    // MARK: - Members
    
    public var selectedColor = #colorLiteral(red: 0.2389388382, green: 0.5892125368, blue: 0.8818323016, alpha: 1)
    
    public var normalColor = #colorLiteral(red: 0.9266347289, green: 0.9417237639, blue: 0.9455887675, alpha: 1) {
        didSet {
            fillColor = normalColor.cgColor
        }
    }
    
    public var isEnabled: Bool = true
    
    public var animationDuration: CFTimeInterval = 0.25
    
    // MARK: - Behavior
    
    public var isSelected: Bool = false {
        didSet {
            setSelected(isSelected)
        }
    }
    
    // MARK: - Internal
    
    private func setSelected(_ selected: Bool) {
        guard isEnabled else { return }
        
        let startColor = selected ? normalColor : selectedColor
        let endColor = selected ? selectedColor : normalColor
        
        animateFill(startColor, endColor)
        animateScale(duration: animationDuration, fromValue: 1, toValue: 1.2)
    }
    
    private func animateFill(_ startColor: UIColor, _ endColor: UIColor) {
        let keyPath = "fillColor"
        let fillAnimation = CABasicAnimation(keyPath: keyPath)
        
        fillAnimation.fromValue = startColor.cgColor
        fillAnimation.toValue = endColor.cgColor
        fillAnimation.duration = animationDuration
        fillAnimation.fillMode = kCAFillModeBoth // kCAFillModeForwards
        fillAnimation.isRemovedOnCompletion = false
        
        add(fillAnimation, forKey: keyPath)
    }
    
    func animateScale(duration: CFTimeInterval, fromValue: CGFloat, toValue: CGFloat) {
        let keyPath = "transform.scale"
        let scaleAnimation: CABasicAnimation = CABasicAnimation(keyPath: keyPath)
        
        scaleAnimation.duration = duration
        scaleAnimation.fromValue = fromValue
        scaleAnimation.toValue = toValue
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = 1
        
        add(scaleAnimation, forKey: keyPath)
    }
    
    // MARK: - Init
    
    public override init() {
        super.init()
        internalInit()
    }
    
    public override init(layer: Any) {
        super.init(layer: layer)
        internalInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        internalInit()
    }
    
    private func internalInit() {
        contentsScale = UIScreen.main.scale
    }
}
