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
    
    var firstCard: UIView!
    var secondCard: UIView!
    
    private func setupCardContainer() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(onPanMoveN(_:)))
        pan.maximumNumberOfTouches = 1
        
        let baseMargin: CGFloat = 8
        let baseCardSize = dummyCard.frame.size
        let baseOrigin = cardContainer.frame.size.center - baseCardSize.center
        
        firstCard = UIView(frame: CGRect(origin: baseOrigin, size: baseCardSize))
        firstCard.backgroundColor = #colorLiteral(red: 0.6678946614, green: 0.9207183719, blue: 0.4710406065, alpha: 1)
        firstCard.makeFlat()
        firstCard.addGestureRecognizer(pan)
        
        secondCard = UIView(frame: CGRect(origin: baseOrigin, size: baseCardSize))
        secondCard.backgroundColor = #colorLiteral(red: 0.2389388382, green: 0.5892125368, blue: 0.8818323016, alpha: 1)
        secondCard.transform = CGAffineTransform.identity.scaledBy(x: 0.94, y: 0.94)
        secondCard.alpha = 0.8
        secondCard.makeFlat()
        
        let transofrmLoss = secondCard.bounds - secondCard.frame
        secondCard.frame.origin.y += transofrmLoss.height / 2 + baseMargin
        
        cardContainer.insertSubview(firstCard, at: 0)
        cardContainer.insertSubview(secondCard, at: 0)
    }
    
    @objc
    private func onPanMoveN(_ r: UIPanGestureRecognizer) {
        guard let card = r.view else { return }
        defer { r.setTranslation(.zero, in: card) }
        
        // 1. move card along with finger
        let moveDistance = r.translation(in: cardContainer)
        // card.center.x = cardContainer.frame.size.center.x + moveDistance.x
        card.center.x += moveDistance.x
        
        let xDistance = card.center.x - cardContainer.center.x
        
        let transformLoss = 1 - secondCard.transform.a
        let normalizedDistance = abs(xDistance) / secondCard.frame.width - transformLoss / 2
        let xPercent = normalizedDistance * 100
        log.debug("moved by: \(xPercent.rounded())")
        // log.debug(xDistance)
        
        let baseAlpha: CGFloat = 0.8
        let alphaLeft = 1 - baseAlpha
        secondCard.alpha = baseAlpha + alphaLeft * normalizedDistance
        log.debug("a: \(secondCard.alpha)")
        
        if r.state == .ended || r.state == .cancelled {
            onPanMoveEnd(r, card)
        }
    }
    
    private func onPanMoveEnd(_ r: UIPanGestureRecognizer, _ card: UIView) {
        UIView.animate(resetCards)
    }
    
    private func resetCards() {
        firstCard.center.x = cardContainer.center.x
        secondCard.alpha = 0.8
    }
    
    @objc
    private func onPanMove(_ r: UIPanGestureRecognizer) {
        guard let card = r.view else { return }
        let velocity = r.velocity(in: card)
        defer { r.setTranslation(.zero, in: card) }
        
        let swipeDelta = r.translation(in: card)
        
        if r.state == .ended || r.state == .cancelled {
            let xDistance = card.center.x - cardContainer.center.x
            if xDistance < 300 {
                UIView.animate(withDuration: 0.25, animations: {
                    card.center.x = self.cardContainer.center.x
                })
            }
            
            return
        }
        
        // card.center += swipeDelta
        card.center.x += swipeDelta.x
        let xDistance = card.center.x - cardContainer.center.x
        let normalizedDistance = xDistance / secondCard.frame.width
        let xPercent = normalizedDistance * 100
        
        // secondCard.center.y -= 20 * normalizedDistance
        
        let firstCardDelta = distance(for: card, in: cardContainer)
        // cardContainer.center - card.center
        let secondCardDelta = distance(for: secondCard, in: cardContainer)
        // cardContainer.center - secondCard.center
        
        let cardContainerCenter = cardContainer.frame.size.center
        let c2CenterDist = distance(for: secondCard, in: cardContainer)
        
        let val = (c2CenterDist.y - cardContainerCenter.y) * normalizedDistance
        secondCard.frame.origin.y = cardContainerCenter.y + val
        
        // let spaceLeftY =
        
        log.debug("d[1]: \(firstCardDelta)")
        log.debug("d[2]: \(secondCardDelta)")
        log.debug("p: \(xPercent.rounded())")
        
        // log.debug("x: \(xDistance) | d: \(swipeDelta)")
    }
    
    // distance to center for: v, in: c
    
    /// Calculates distance of view's center to it's container center.
    private func distance(for subview: UIView, in container: UIView) -> CGPoint {
        let containerFrame = container.frame
        let containerCenter = CGPoint(x: containerFrame.width / 2, y: containerFrame.height / 2)
        
        return subview.frame.center - containerCenter
    }
}

public extension CGSize {
    public var center: CGPoint {
        return CGPoint(x: width / 2, y: height / 2)
    }
    
    public static func -(_ lhs: CGSize, _ rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }
}

public extension CGRect {
//    public var center: CGPoint {
//        return CGPoint(x: width / 2, y: height / 2)
//    }
    
    public static func -(_ lhs: CGRect, _ rhs: CGRect) -> CGRect {
        let newOrigin = lhs.origin - rhs.origin
        let newSize = lhs.size - rhs.size
        
        return CGRect(origin: newOrigin, size: newSize)
    }
    
    public var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}
