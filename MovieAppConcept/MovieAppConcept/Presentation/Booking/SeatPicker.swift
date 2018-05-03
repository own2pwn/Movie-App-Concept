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
    
    private let engine = SeatRenderEngine.shared
    
    public var itemSpacing: CGFloat = 8
    
    public var setSpacing: CGFloat = 4
    
    public var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    
    // MARK: - Behavior
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        defer { super.touchesBegan(touches, with: event) }
        
        if let location = touches.first?.location(in: self) {
            if let layers = layer.sublayers {
                for sl in layers {
                    guard let seat = sl.hitTest(location) as? SeatLayer else { continue }
                    seat.isSelected = !seat.isSelected
                }
            }
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        defer { super.touchesMoved(touches, with: event) }
        
        print("[2]")
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        defer { super.touchesEnded(touches, with: event) }
        
        if let location = touches.first?.location(in: self) {
            if let sb = layer.hitTest(location) {
                print("[3] - \(sb)")
            }
        }
    }
    
    // MARK: - Interface
    
    public func add(_ items: SeatArray, starting at: CGPoint) {
        let startPoint = at
        let itemSize = calculateSeatSize()
        let config = SeatRenderEngineConfig(startPoint: startPoint, itemSize: itemSize, itemSpacing: itemSpacing)
        
        engine.render(items, in: self, config: config)
    }
    
    // MARK: - Internal
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        internalInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        internalInit()
    }
    
    private func internalInit() {
        isMultipleTouchEnabled = false
    }
    
    private func calculateSeatSize() -> CGSize {
        let maxInLine: CGFloat = 12
        let availableWidth = frame.width - contentInsets.left - contentInsets.right - 2 * setSpacing - (maxInLine - 1) * itemSpacing
        
        let itemWidth = availableWidth / maxInLine
        let seatSize = CGSize(width: itemWidth, height: itemWidth * 0.7)
        
        return seatSize
    }
}
