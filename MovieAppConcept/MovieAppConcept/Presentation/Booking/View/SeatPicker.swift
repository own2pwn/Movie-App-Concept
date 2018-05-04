//
//  SeatPicker.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 03.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

public final class SeatPicker: UIView {

    // MARK: - Members
    
    private let engine = StageRenderEngine.shared
    
    public var seatSpacing: CGFloat = 6
    
    public var blockSpacing: CGFloat = 4
    
    public var lineSpacing: CGFloat = 10
    
    public var contentInsets: UIEdgeInsets = .zero
    
    // MARK: - Behavior
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        defer { super.touchesMoved(touches, with: event) }
        
        // TODO: do light selection animation
        // i.e. we can just let it reverse after all
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        defer { super.touchesEnded(touches, with: event) }
        
        guard let location = touches.first?.location(in: self) else { return }
        animateLayer(at: location)
    }
    
    // MARK: - Interface
    
    public func add(_ stage: Stage, starting at: CGPoint) {
        let startPoint = at
        let itemSize = calculateSeatSize()
        let config = StageRenderEngineConfig(itemSize: itemSize, itemSpacing: seatSpacing, blockSpacing: blockSpacing, lineSpacing: lineSpacing, startPoint: startPoint)
        
        engine.render(stage, in: self, config: config)
    }
    
    // MARK: - Internal
    
    private func calculateSeatSize() -> CGSize {
        let maxInLine: CGFloat = 12
        let availableWidth = frame.width - contentInsets.left - contentInsets.right - 2 * blockSpacing - (maxInLine - 1) * seatSpacing
        
        let itemWidth = availableWidth / maxInLine
        let seatSize = CGSize(width: itemWidth, height: itemWidth * 0.7)
        
        return seatSize
    }
    
    private func animateLayer(at location: CGPoint) {
        guard let layers = layer.sublayers else { return }
        for sl in layers {
            guard let seat = sl.hitTest(location) as? SeatLayer else { continue }
            seat.isSelected.toggle()
        }
    }
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        internalInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        internalInit()
    }
    
    private func internalInit() {
        contentInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        isMultipleTouchEnabled = false
    }
}
