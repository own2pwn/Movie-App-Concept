//
//  SeatRenderEngine.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 03.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

public struct SeatRenderEngineConfig {
    let startPoint: CGPoint
    let itemSize: CGSize
    let itemSpacing: CGFloat
}

public final class SeatLayer: CAShapeLayer {

    // MARK: - Members
    
    public var selectedColor = #colorLiteral(red: 0.2389388382, green: 0.5892125368, blue: 0.8818323016, alpha: 1)
    
    public var normalColor = #colorLiteral(red: 0.9266347289, green: 0.9417237639, blue: 0.9455887675, alpha: 1) {
        didSet {
            fillColor = normalColor.cgColor
        }
    }
    
    public var isEnabled: Bool = true
    
    // MARK: - Behavior
    
    public var isSelected: Bool = false {
        didSet {
            setSelected(isSelected)
        }
    }
    
    public var animationDuration: CFTimeInterval = 0.25
    
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

public final class SeatRenderEngine {

    // MARK: - Members
    
    public static let shared = SeatRenderEngine()
    
    // MARK: - Interface
    
    public func render(_ seats: SeatArray, in container: UIView, config: SeatRenderEngineConfig) {
        var linePosition = config.startPoint
        
        for row in seats {
            renderLine(row, in: container, start: linePosition, config: config)
            
            linePosition.y += config.itemSpacing + config.itemSize.height
        }
    }
    
    // MARK: - Internal
    
    private func renderLine(_ places: [SeatType], in container: UIView, start: CGPoint, config: SeatRenderEngineConfig) {
        let itemSpacing = config.itemSpacing
        let itemSize = config.itemSize
        
        var origin = start
        
        for place in places {
            guard place.shouldRender else {
                let spacing = place.spacing
                origin.x += spacing > 0 ? spacing : itemSpacing + itemSize.width
                continue
            }
            let seat = makeSeat(place, size: itemSize, in: origin)
            container.layer.addSublayer(seat)
            
            origin.x += itemSpacing + itemSize.width
        }
    }
    
    private func makeSeat(_ type: SeatType, size: CGSize, in place: CGPoint) -> CAShapeLayer {
        let seatFrame = CGRect(origin: place, size: size)
        let seatPath = UIBezierPath(roundedRect: CGRect(origin: .zero, size: size), byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 4, height: 4))
        
        let seatLayer = SeatLayer()
        seatLayer.path = seatPath.cgPath
        seatLayer.frame = seatFrame
        seatLayer.normalColor = type.renderColor
        seatLayer.isEnabled = type.isEnabled
        
        let textLayer = CATextLayer(layer: seatLayer)
        textLayer.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        textLayer.fontSize = 12
        //textLayer.string = "\(number)"
        textLayer.foregroundColor = #colorLiteral(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 1).cgColor
        
        textLayer.frame.size = textLayer.preferredFrameSize()
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.frame.origin.x = (seatLayer.frame.width - textLayer.frame.size.width) / 2
        textLayer.frame.origin.y = (seatLayer.frame.height - textLayer.frame.size.height) / 2
        
        seatLayer.addSublayer(textLayer)
        
        return seatLayer
    }
}
