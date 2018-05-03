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
        animateScale(fromValue: 1, toValue: 1.2)
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
