//
//  BookingController.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 02.05.18.
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

final class BookingController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet var heading: UIView!
    
    @IBOutlet var legendContainer: UIView!
    
    @IBOutlet var legendSeats: [UIView]!
    
    @IBOutlet var screenContainer: UIView!
    
    @IBOutlet var seatPickerContainer: UIView!
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    // MARK: - Methods
    
    private func setupScreen() {
        setup()
    }
    
    private func setup() {
        let setup = [setColors, setupHeading, setupLegend, renderScreen, renderSeats]
        setup.forEach { $0() }
    }
    
    private func setColors() {
    }
    
    private func setupHeading() {
        heading.addHorizontalSeparator(at: .bot, margin: 16, color: #colorLiteral(red: 0.7617311433, green: 0.7720834954, blue: 0.78, alpha: 0.15))
    }
    
    private func setupLegend() {
        legendContainer.addHorizontalSeparator(at: .bot, margin: 16, color: #colorLiteral(red: 0.7617311433, green: 0.7719357531, blue: 0.78, alpha: 0.15))
        
        for seat in legendSeats {
            let roundMask = CAShapeLayer()
            roundMask.path = UIBezierPath(roundedRect: seat.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 4, height: 4)).cgPath
            roundMask.fillColor = seat.backgroundColor?.cgColor
            
            seat.layer.mask = roundMask
        }
    }
    
    private func renderScreen() {
        let path = UIBezierPath()
        let lineLayer = CAShapeLayer()
        
        let baseY: CGFloat = 64
        let controlY: CGFloat = baseY - 46 // 44
        
        let margin: CGFloat = 16
        let rightInset: CGFloat = view.frame.width - margin
        
        let start = CGPoint(x: margin, y: baseY)
        let end = CGPoint(x: rightInset, y: baseY)
        let control = CGPoint(x: (end.x - start.x) / 2 + start.x, y: controlY)
        
        path.move(to: start)
        // path.addArc(withCenter: CGPoint(x: control.x, y: baseY), radius: (end.x - start.x) / 2, startAngle: -.pi, endAngle: -.pi / 2, clockwise: true)
        path.addQuadCurve(to: end, controlPoint: control)
        
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.strokeColor = #colorLiteral(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 1).cgColor
        lineLayer.lineWidth = 3
        lineLayer.path = path.cgPath
        lineLayer.contentsScale = UIScreen.main.scale
        lineLayer.lineCap = kCALineCapRound
        
        screenContainer.layer.addSublayer(lineLayer)
        
        // TODO: add shadow
    }
    
    private func calculateSeatSize() -> CGSize {
        let seatSpacing: CGFloat = 8
        let setSpacing: CGFloat = 4
        let margin: CGFloat = 16
        
        let maxInLine: CGFloat = 12
        var availableWidth = seatPickerContainer.frame.width - 2 * margin
        let freeContainer = UIView(frame: CGRect(origin: CGPoint(x: margin, y: 16), size: CGSize(width: availableWidth, height: 128)))
        availableWidth -= 2 * setSpacing
        availableWidth -= seatSpacing * (maxInLine - 1)
        
        let itemWidth = availableWidth / maxInLine
        let seatSize = CGSize(width: itemWidth, height: itemWidth * 0.7)
        
        freeContainer.backgroundColor = #colorLiteral(red: 0.6678946614, green: 0.9207183719, blue: 0.4710406065, alpha: 1)
        // seatPickerContainer.addSubview(freeContainer)
        
        let seatContainer = UIView(frame: CGRect(origin: .zero, size: CGSize(width: availableWidth, height: 128)))
        seatContainer.backgroundColor = #colorLiteral(red: 0.2389388382, green: 0.5892125368, blue: 0.8818323016, alpha: 1)
        // freeContainer.addSubview(seatContainer)
        
        return seatSize
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
    
    private func renderSeatsLine(_ places: [SeatType], size: CGSize, starting at: CGPoint) {
        let seatSpacing: CGFloat = 8
        var origin = at
        
        for place in places {
            guard place.shouldRender else {
                let spacing = place.spacing
                origin.x += spacing > 0 ? spacing : seatSpacing + size.width
                continue
            }
            let seat = makeSeat(size: size, in: origin, place.renderColor)
            seatPickerContainer.layer.addSublayer(seat)
            
            origin.x += seatSpacing + size.width
        }
    }
    
    private func renderSeats() {
        let itemSize = calculateSeatSize()
        let itemSpacing: CGFloat = 8
        let startPoint = CGPoint(x: 16, y: 16)
        
        let items = SeatProvider.shared.get()
        let render = SeatRenderEngine.shared
        let config = SeatRenderEngineConfig(startPoint: startPoint, itemSize: itemSize, itemSpacing: itemSpacing)
        
        render.render(items, in: seatPickerContainer, config: config)
    }
}

public extension UIView {
    public enum SeparatorPosition {
        case top, bot
    }
    
    public func addHorizontalSeparator(at position: SeparatorPosition, margin: CGFloat, color: UIColor) {
        let separatorLayer = CALayer()
        let mySize = bounds.size
        
        let yPosition: CGFloat = position == .top ? 0 : mySize.height
        let origin = CGPoint(x: margin, y: yPosition)
        
        separatorLayer.frame = CGRect(origin: origin, size: CGSize(width: mySize.width - 2 * margin, height: 1))
        separatorLayer.backgroundColor = color.cgColor
        
        layer.addSublayer(separatorLayer)
    }
}
