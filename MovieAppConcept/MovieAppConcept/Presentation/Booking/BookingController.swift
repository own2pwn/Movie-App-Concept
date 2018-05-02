//
//  BookingController.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 02.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

final class BookingController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet var heading: UIView!
    
    @IBOutlet var dummySeat: UIView!
    
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
        let setup = [setColors, setupHeading]
        setup.forEach { $0() }
    }
    
    private func setColors() {
    }
    
    private func setupHeading() {
        heading.addHorizontalSeparator(at: .bot, margin: 16, color: #colorLiteral(red: 0.7617311433, green: 0.7719357531, blue: 0.78, alpha: 0.9))
        
        let shadowLayer = CAShapeLayer()
        
        shadowLayer.path = UIBezierPath(roundedRect: dummySeat.bounds, cornerRadius: 4).cgPath
        shadowLayer.fillColor = UIColor.clear.cgColor
        
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 3
        
        //dummySeat.layer.insertSublayer(shadowLayer, at: 0)
        dummySeat.layer.addSublayer(shadowLayer)
        
//        let roundedSeatPath = UIBezierPath(roundedRect: dummySeat.frame, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 4, height: 4))
//        let roundedMask = CAShapeLayer()
//        roundedMask.path = roundedSeatPath.cgPath
//        roundedMask.backgroundColor = UIColor.red.cgColor
//        roundedMask.fillColor = UIColor.red.cgColor
//        roundedMask.position = dummySeat.center
//
//        dummySeat.layer.addSublayer(roundedMask)
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
