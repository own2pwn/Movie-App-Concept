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
        defer { r.setTranslation(.zero, in: card) }
        
        let swipeDelta = r.translation(in: card)
        let xDistance = swipeDelta.x
        
        if r.state == .ended || r.state == .cancelled {
            return
        }
        
        card.center += swipeDelta
        
        // log.debug("x: \(xDistance) | d: \(swipeDelta)")
    }
}
