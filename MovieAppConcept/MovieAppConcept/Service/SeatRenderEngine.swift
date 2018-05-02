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

public final class SeatRenderEngine {

    // MARK: - Members
    
    public static let shared = SeatRenderEngine()
    
    // MARK: - Interface
    
    public func render(_ seats: [[SeatType]], in container: UIView, config: SeatRenderEngineConfig) {
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
            let seat = makeSeat(size: itemSize, in: origin, place.renderColor)
            container.layer.addSublayer(seat)
            
            origin.x += itemSpacing + itemSize.width
        }
    }
    
    private func makeSeat(size: CGSize, in place: CGPoint, _ color: UIColor) -> CAShapeLayer {
        let seatFrame = CGRect(origin: place, size: size)
        let seatPath = UIBezierPath(roundedRect: CGRect(origin: .zero, size: size), byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 4, height: 4))
        
        let seatLayer = CAShapeLayer()
        seatLayer.path = seatPath.cgPath
        seatLayer.frame = seatFrame
        seatLayer.fillColor = color.cgColor
        seatLayer.contentsScale = UIScreen.main.scale
        
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
