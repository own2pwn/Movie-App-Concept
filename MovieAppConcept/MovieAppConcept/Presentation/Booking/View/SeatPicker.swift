//
//  SeatPicker.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 03.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

public protocol SeatPickerDelegate: class {
    func seatPicker(_ picker: SeatPicker, selectedSeatsDidChange seats: Set<SeatLayer>)
}

public final class SeatPicker: UIView {

    // MARK: - Members
    
    private let engine = StageRenderEngine.shared
    
    public var seatSpacing: CGFloat = 6
    
    public var blockSpacing: CGFloat = 4
    
    public var lineSpacing: CGFloat = 10
    
    public var contentInsets: UIEdgeInsets = .zero
    
    public var delegate: SeatPickerDelegate?
    
    private var selectedSeats = Set<SeatLayer>()
    
    private var widthLoss: CGFloat = 0
    
    // MARK: - Behavior
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        defer { super.touchesEnded(touches, with: event) }
        
        guard let location = touches.first?.location(in: self) else { return }
        animateLayer(at: location)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        frame.origin.x = widthLoss / 2
    }
    
    // MARK: - Interface
    
    public func add(_ stage: Stage, starting at: CGPoint) {
        let startPoint = at
        let itemSize = calculateSeatSize(for: stage)
        let config = StageRenderEngineConfig(itemSize: itemSize, itemSpacing: seatSpacing, blockSpacing: blockSpacing, lineSpacing: lineSpacing, startPoint: startPoint)
        
        engine.render(stage, in: self, config: config)
    }
    
    public func get() -> Set<SeatLayer> {
        return selectedSeats
    }
    
    // MARK: - Internal
    
    private func calculateSeatSize(for stage: Stage) -> CGSize {
        // let's say we have this in our model
        let maxInLine: CGFloat = 12 // maxSeatsInLineBlock(in: suitableLineBlocks)
        let linesCount: CGFloat = 12 // linesInBlock(in: suitableLineBlocks)
        let blocksCount: CGFloat = 2
        
        let availableWidth = frame.width - contentInsets.left - contentInsets.right - blocksCount * blockSpacing - (maxInLine - 1) * seatSpacing
        let availableHeight = frame.height - contentInsets.top - contentInsets.bottom - (linesCount - 1) * lineSpacing
        
        let mult: CGFloat = 0.7
        var maxWidth = availableWidth / maxInLine
        let maxHeight = availableHeight / linesCount
        
        if maxWidth * mult > maxHeight {
            widthLoss = (maxInLine - 1) * (maxWidth - maxHeight)
            // just a quick hack to center container.
            // for best experience run on iPhone X
            
            maxWidth = maxHeight
        }
        
        let seatSize = CGSize(width: maxWidth, height: maxWidth * mult)
        
        return seatSize
    }
    
    private func linesInBlock(in blocks: [Block<Line>]) -> Int {
        return blocks.map { $0.items.count }.reduce(0, +)
    }
    
    private func maxSeatsInLineBlock(in blocks: [Block<Line>]) -> Int {
        let seatsPerLineArr = blocks.flatMap {
            $0.items.map {
                $0.seatBlocks.map({ block -> Int in
                    let suitable = block.items.filter { $0.shouldRender }
                    return suitable.count
                })
            }
        }
        
        let seatsPerLine = seatsPerLineArr.map { $0.reduce(0, +) }
        
        return seatsPerLine.max()!
    }
    
    private func animateLayer(at location: CGPoint) {
        guard let layers = layer.sublayers else { return }
        for sl in layers {
            guard let seat = sl.hitTest(location) as? SeatLayer else { continue }
            seat.isSelected.toggle()
            
            if selectedSeats.remove(seat) == nil {
                selectedSeats.insert(seat)
            }
            delegate?.seatPicker(self, selectedSeatsDidChange: selectedSeats)
            
            break
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
