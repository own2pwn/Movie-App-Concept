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
    
    private func setupCardContainer() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(onPanMove(_:)))
        pan.maximumNumberOfTouches = 1
        
        let firstCard = UIView(frame: dummyCard.frame)
        firstCard.backgroundColor = dummyCard.backgroundColor
        firstCard.makeFlat()
        firstCard.addGestureRecognizer(pan)
        
        cardContainer.addSubview(firstCard)
    }
    
    @objc
    private func onPanMove(_ r: UIPanGestureRecognizer) {
        guard let card = r.view else { return }
        let velocity = r.velocity(in: card)
        // defer { r.setTranslation(.zero, in: card) }
        
        let swipeDelta = r.translation(in: card).x
        let containerFrame = cardContainer.bounds
        let containerCenter = CGPoint(x: containerFrame.width / 2, y: containerFrame.height / 2)
        let xDistance = containerCenter.x - card.center.x
        
        if r.state == .ended || r.state == .cancelled {
            r.setTranslation(.zero, in: card)
            return
        }
        
        log.debug("x: \(xDistance) | d: \(swipeDelta)")
    }
}
