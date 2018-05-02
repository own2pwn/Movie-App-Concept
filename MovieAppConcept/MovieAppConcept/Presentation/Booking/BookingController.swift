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
        let margin: CGFloat = 16
        let containerSize = heading.frame.size
        
        let separatorLayer = CALayer()
        separatorLayer.frame = CGRect(origin: CGPoint(x: margin, y: containerSize.height), size: CGSize(width: containerSize.width - 2 * margin, height: 1))
        separatorLayer.backgroundColor = UIColor.red.cgColor
        heading.layer.addSublayer(separatorLayer)
    }
}

public extension UIView {
    public enum SeparatorPosition {
        case top, bot
    }
    
    public func addHorizontalSeparator(at position: SeparatorPosition, margin: CGFloat) {
        let separatorLayer = CALayer()
        let mySize = bounds.size
        
        let yPosition: CGFloat = position == .top ? 0 : mySize.height
        let origin = CGPoint(x: margin, y: yPosition)
        
        separatorLayer.frame = CGRect(origin: origin, size: CGSize(width: mySize.width - 2 * margin, height: 1))
        separatorLayer.backgroundColor = UIColor.red.cgColor
        
        layer.addSublayer(separatorLayer)
    }
}
