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
        
        let baseMargin: CGFloat = 8
        let baseCardSize = dummyCard.frame.size
        let baseOrigin = cardContainer.frame.size.center - baseCardSize.center
        
        let firstCard = UIView(frame: CGRect(origin: baseOrigin, size: baseCardSize))
        firstCard.backgroundColor = #colorLiteral(red: 0.6678946614, green: 0.9207183719, blue: 0.4710406065, alpha: 1)
        firstCard.makeFlat()
        
        let secondCard = UIView(frame: CGRect(origin: baseOrigin, size: baseCardSize))
        secondCard.backgroundColor = #colorLiteral(red: 0.2389388382, green: 0.5892125368, blue: 0.8818323016, alpha: 1)
        secondCard.makeFlat()
        secondCard.transform = CGAffineTransform.identity.scaledBy(x: 0.94, y: 0.94)
        
        let transofrmHeightLoss = secondCard.bounds.height - secondCard.frame.height
        secondCard.frame.origin.y += transofrmHeightLoss / 2 + baseMargin
        
        cardContainer.insertSubview(firstCard, at: 0)
        cardContainer.insertSubview(secondCard, at: 0)
        
//        let firstCard = UIView(frame: dummyCard.frame)
//        firstCard.backgroundColor = dummyCard.backgroundColor
//        firstCard.makeFlat()
//        firstCard.addGestureRecognizer(pan)
//
//        secondCard = UIView(frame: firstCard.frame)
//        secondCard.backgroundColor = #colorLiteral(red: 0.2389388382, green: 0.5892125368, blue: 0.8818323016, alpha: 1)
//        secondCard.makeFlat()
//        secondCard.transform = CGAffineTransform.identity.scaledBy(x: 0.94, y: 0.94)
//
//        secondCard.frame.origin.x = (cardContainer.frame.width - secondCard.frame.width) / 2
//        secondCard.frame.origin.y += 24
//
//        cardContainer.addSubview(secondCard)
//        cardContainer.addSubview(firstCard)
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
}

public extension CGRect {
//    public var center: CGPoint {
//        return CGPoint(x: width / 2, y: height / 2)
//    }
    
    public var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}
