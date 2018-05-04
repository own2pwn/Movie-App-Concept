//
//  BookingInfoController.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 04.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

public extension UIView {
    public func makeFlat(with radius: CGFloat = 8) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}

public extension CGPoint {
    public static func +(_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    public static func -(_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    public static func +=(_ lhs: inout CGPoint, _ rhs: CGPoint) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }
}

final class BookingInfoController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet var cardContainer: UIView!
    
    @IBOutlet var dummyCard: UIView!
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
    
    // MARK: - Methods
    
    private func setupScreen() {
        setup()
    }
    
    private func setup() {
        let setup = [setupCardContainer]
        setup.forEach { $0() }
    }
    
    var secondCard: UIView!
    
    private func setupCardContainer() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(onPanMove(_:)))
        pan.maximumNumberOfTouches = 1
        
        let firstCard = UIView(frame: dummyCard.frame)
        firstCard.backgroundColor = dummyCard.backgroundColor
        firstCard.makeFlat()
        firstCard.addGestureRecognizer(pan)
        
        secondCard = UIView(frame: firstCard.frame)
        secondCard.backgroundColor = #colorLiteral(red: 0.2389388382, green: 0.5892125368, blue: 0.8818323016, alpha: 1)
        secondCard.makeFlat()
        secondCard.transform = CGAffineTransform.identity.scaledBy(x: 0.94, y: 0.94)
        secondCard.center.x = firstCard.center.x
        secondCard.frame.origin.y += 20
        
        cardContainer.addSubview(secondCard)
        cardContainer.addSubview(firstCard)
    }
    
    @objc
    private func onPanMove(_ r: UIPanGestureRecognizer) {
        guard let card = r.view else { return }
        let velocity = r.velocity(in: card)
        defer { r.setTranslation(.zero, in: card) }
        
        let swipeDelta = r.translation(in: card)
        
        if r.state == .ended || r.state == .cancelled {
            return
        }
        
        // card.center += swipeDelta
        card.center.x += swipeDelta.x
        let xDistance = card.center.x - cardContainer.center.x
        let normalizedDistance = xDistance / secondCard.frame.width
        let xPercent = normalizedDistance * 100
        
        // secondCard.center.y -= 20 * normalizedDistance
        
        let firstCardDelta = distance(between: card.frame, and: cardContainer.frame) // cardContainer.center - card.center
        let secondCardDelta = cardContainer.center - secondCard.center
        
        log.debug("d[1]: \(firstCardDelta)")
        log.debug("d[2]: \(secondCardDelta)")
        log.debug("p: \(xPercent.rounded())")
        
        // log.debug("x: \(xDistance) | d: \(swipeDelta)")
    }
    
    // distance to center for: v, in: c
    private func distance(between v1: CGRect, and v2: CGRect) -> CGPoint {
        let dx = v2.minX - v1.minX
        let dy = v2.minY - v1.minY
        
        return CGPoint(x: dx, y: dy)
    }
}

public extension CGRect {
    public var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}
