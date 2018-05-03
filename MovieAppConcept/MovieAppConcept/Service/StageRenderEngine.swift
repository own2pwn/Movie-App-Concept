//
//  SeatRenderEngine.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 03.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

public struct StageRenderEngineConfig {
    let itemSize: CGSize
    let itemSpacing: CGFloat
    
    let blockSpacing: CGFloat
    let lineSpacing: CGFloat
    
    let startPoint: CGPoint
}

public final class StageRenderEngine {

    // MARK: - Members
    
    public static let shared = StageRenderEngine()
    
    // MARK: - Interface
    
    public func render(_ stage: Stage, in cinema: UIView, config: StageRenderEngineConfig) {
        let cinemaLayer = cinema.layer
        let lineSpacing = config.lineSpacing
        var lineOrigin = config.startPoint
        
        for lineBlock in stage.lineBlocks {
            // defer { lineOrigin.y += lin }
            
            renderLineBlock(lineBlock)
        }
        
//        for line in stage.lines {
//            renderLine(line, in: cinemaLayer, start: linePosition, config: config)
//
//            linePosition.y += config.itemSpacing + config.itemSize.height
//        }
    }
    
    private func renderLineBlock(_ block: Block<Line>, starting at: CGPoint, in cinema: CALayer, with config: StageRenderEngineConfig) {
        let lineSpacing = config.lineSpacing
        let lineHeight = config.itemSize.height
        var origin = at
        
        for line in block.items {
            renderLine(line, starting: at, in: cinema, with: config)
            origin.y += lineSpacing + lineHeight
        }
    }
    
    private func renderLine(_ line: Line, starting at: CGPoint, in cinema: CALayer, with config: StageRenderEngineConfig) {
        let blockSpacing = config.blockSpacing
        var origin = at
        
        for seatBlock in line.seatBlocks {
            let newPosition = renderSeatBlock(seatBlock, starting: origin, in: cinema, with: config)
            origin.x = blockSpacing + newPosition.x
        }
    }
    
    private func renderSeatBlock(_ block: Block<SeatType>, starting at: CGPoint, in cinema: CALayer, with config: StageRenderEngineConfig) -> CGPoint {
        let seatSize = config.itemSize
        let seatSpacing = config.itemSpacing
        var origin = at
        
        for seatType in block.items {
            renderSeat(of: seatType, size: seatSize, at: origin, in: cinema)
            origin.x += seatSpacing + seatSize.width
        }
        
        return origin
    }
    
    private func renderSeat(of type: SeatType, size: CGSize, at point: CGPoint, in cinema: CALayer) {
        let seatLayer = makeSeatLayer(of: type, size: size, in: point)
        cinema.addSublayer(seatLayer)
    }
    
    // MARK: - Internal
    
    private func renderLine(of type: LineType, in cinema: CALayer, start: CGPoint, config: StageRenderEngineConfig) -> CGPoint {
        let spacing = config.blockSpacing
        var origin = start
        
        guard type.shouldRender else
        
        for block in line.blocks {
            let lastPoint = renderBlock(block, in: cinema, starting: origin, config: config)
            
            origin.x = lastPoint.x + spacing
        }
    }
    
    private func renderLine(_ line: Line, in cinema: CALayer, start: CGPoint, config: StageRenderEngineConfig) {
        let spacing = config.blockSpacing
        var origin = start
        
        for block in line.seatBlocks {
            let lastPoint = renderBlock(block, in: cinema, starting: origin, config: config)
            
            origin.x = lastPoint.x + spacing
        }
    }
    
    private func renderBlock(_ block: Block, in cinema: CALayer, starting at: CGPoint, config: StageRenderEngineConfig) -> CGPoint {
        let spacing = config.itemSpacing
        let seatSize = config.itemSize
        var origin = at
        
        for type in block.seats {
            defer { origin.x += spacing + seatSize.width }
            guard type.shouldRender else { continue }
            
            renderSeat(of: type, size: seatSize, at: origin, in: cinema)
        }
        
        return origin
    }
    
    private func renderSeat(of type: SeatType, size: CGSize, at point: CGPoint, in cinema: CALayer) {
        let seatLayer = makeSeatLayer(of: type, size: size, in: point)
        cinema.addSublayer(seatLayer)
    }
    
    private func makeSeatLayer(of type: SeatType, size: CGSize, in place: CGPoint) -> CAShapeLayer {
        let seatFrame = CGRect(origin: place, size: size)
        let seatPath = UIBezierPath(roundedRect: CGRect(origin: .zero, size: size), byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 4, height: 4))
        
        let seatLayer = SeatLayer()
        seatLayer.path = seatPath.cgPath
        seatLayer.frame = seatFrame
        seatLayer.normalColor = type.renderColor
        seatLayer.isEnabled = type.isEnabled
        
        return seatLayer
        
        /*
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
         */
    }
}
