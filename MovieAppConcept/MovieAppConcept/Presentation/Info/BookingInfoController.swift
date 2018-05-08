//
//  BookingInfoController.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 04.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

final class BookingInfoController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet var cardContainer: UIView!
    
    @IBOutlet var dummyCard: UIView!
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        firstCard.backgroundColor = #colorLiteral(red: 0.2389388382, green: 0.5892125368, blue: 0.8818323016, alpha: 1)
        firstCard.makeFlat()
        firstCard.addGestureRecognizer(pan)
        
        secondCard = UIView(frame: CGRect(origin: baseOrigin, size: baseCardSize))
        secondCard.backgroundColor = #colorLiteral(red: 0.6678946614, green: 0.9207183719, blue: 0.4710406065, alpha: 1)
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
        defer { r.setTranslation(.zero, in: cardContainer) }
        
        // 1. move card along with finger
        let moveDistance = r.translation(in: cardContainer)
        // card.center.x = cardContainer.frame.size.center.x + moveDistance.x
        card.center.x += moveDistance.x
        
        let xDistance = card.center.x - cardContainer.center.x
        let absDistance = abs(xDistance)
        
        var shouldCancel = true
        
        if absDistance >= 200 {
            r.isEnabled = false
            shouldCancel = false
            
            UIView.animate { [cardContainer = cardContainer!, secondCard = secondCard!] in
                card.transform = CGAffineTransform.identity.scaledBy(x: 0.94, y: 0.94)
                card.alpha = 0.8
                
                secondCard.transform = .identity
                secondCard.alpha = 1
                
                secondCard.center = cardContainer.frame.size.center
                
                card.center.x = cardContainer.center.x
                card.frame.origin.y = 54
                
                cardContainer.sendSubview(toBack: card)
                card.removeGestureRecognizer(r)
                secondCard.addGestureRecognizer(r)
                r.isEnabled = true
            }
            
            return
        }
        
        let transformLoss = 1 - secondCard.transform.a
        var normalizedDistance = absDistance
        normalizedDistance /= secondCard.frame.width - transformLoss / 2
        normalizedDistance.rightBounded(to: 1)
        
        let xPercent = normalizedDistance * 100
        // log.debug("moved by: \(xPercent.rounded())")
        // log.debug(xDistance)
        
        let baseTransform = CGAffineTransform.identity
        let leftTransform = CGAffineTransform.identity.scaledBy(x: 0.94, y: 0.94) - card.transform
        let newTransform = baseTransform + leftTransform * normalizedDistance
        card.transform = newTransform
        
        let baseAlpha: CGFloat = 1
        let alphaLeft = 0.8 - baseAlpha
        let newAlpha = baseAlpha + alphaLeft * normalizedDistance
        card.alpha = newAlpha
        
        let updates = [updateAlpha, updateTransform, updateOrigin]
        updates.forEach { $0(normalizedDistance) }
        
        if r.state == .ended || r.state == .cancelled {
            guard shouldCancel else { return }
            onPanMoveEnd(r, card)
        }
    }
    
    private func updateOrigin(for distance: CGFloat) {
        let baseY: CGFloat = 53.042
        let leftY = 24 - secondCard.frame.origin.y
        let newY = baseY + leftY * distance
        secondCard.frame.origin.y = newY.bound(min: 24, baseY)
    }
    
    private func updateTransform(for distance: CGFloat) {
        let baseTransform = CGAffineTransform.identity.scaledBy(x: 0.94, y: 0.94)
        let leftTransform = CGAffineTransform.identity - secondCard.transform
        let newTransform = baseTransform + leftTransform * distance
        secondCard.transform = newTransform
    }
    
    private func updateAlpha(for distance: CGFloat) {
        let baseAlpha: CGFloat = 0.8
        let alphaLeft = 1 - baseAlpha
        let newAlpha = baseAlpha + alphaLeft * distance
        secondCard.alpha = newAlpha
    }
    
    private func onPanMoveEnd(_ r: UIPanGestureRecognizer, _ card: UIView) {
        UIView.animate(resetCards)
    }
    
    private func resetCards() {
        secondCard.alpha = 0.8
        secondCard.transform = CGAffineTransform.identity.scaledBy(x: 0.94, y: 0.94)
        secondCard.frame.origin.y = 53.042
        
        firstCard.center.x = cardContainer.center.x
        firstCard.transform = .identity
        firstCard.alpha = 1
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
