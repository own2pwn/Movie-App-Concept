//
//  BookingController.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 02.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import PassKit
import UIKit

final class BookingController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet var heading: UIView!
    
    @IBOutlet var legendContainer: UIView!
    
    @IBOutlet var legendSeats: [UIView]!
    
    @IBOutlet var screenContainer: UIView!
    
    @IBOutlet var seatPickerContainer: SeatPicker!
    
    @IBOutlet var buyButton: EPButton!
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !didRender {
            renderSeats()
            didRender = true
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Members
    
    private var didRender = false
    
    // MARK: - Methods
    
    private func setupScreen() {
        setup()
    }
    
    private func setup() {
        let setup = [setupHeading, setupLegend, renderScreen, setupBuyButton]
        setup.forEach { $0() }
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
    
    private func renderSeats() {
        let startPoint = CGPoint(x: 16, y: 16)
        let items = SeatProvider.shared.get()
        
        seatPickerContainer.add(items, starting: startPoint)
        seatPickerContainer.delegate = self
    }
    
    private func setupBuyButton() {
        buyButton.cornerRadius = 14
        buyButton.isCheckable = false
        
        buyButton.highlightTitleColor = #colorLiteral(red: 0.9290803671, green: 0.9371851087, blue: 0.9403076768, alpha: 1)
        buyButton.normalTitleColor = buyButton.currentTitleColor
        buyButton.normalColor = buyButton.backgroundColor
        buyButton.highlightColor = #colorLiteral(red: 0.2054144144, green: 0.5233783722, blue: 0.7912093401, alpha: 1)
        
        buyButton.onHighlight = { $0.transform = CGAffineTransform.identity.scaledBy(x: 0.94, y: 0.94) }
        buyButton.onUnhighlight = { $0.transform = .identity }
        
        buyButton.makeFlat()
        buyButton.onPrimaryAction = buyTickets
        buyButton.alpha = 0
        
        buyButton.titleLabel?.adjustsFontSizeToFitWidth = true
        buyButton.titleLabel?.minimumScaleFactor = 0.75
    }
    
    // MARK: - Actions
    
    @IBAction func goBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showNext(_ sender: UIButton) {
        performSegue(withIdentifier: "showBookingInfo", sender: self)
    }
}

extension BookingController: SeatPickerDelegate {
    private func buyTickets(_ sender: EPButton) {
        let payer = ApplePayer()
        let tickets = seatPickerContainer.get()
        
        payer.presentOverlay(for: tickets.count, ticketPrice: 400, movie: "Back To The Future")
    }
    
    func seatPicker(_ picker: SeatPicker, selectedSeatsDidChange seats: Set<SeatLayer>) {
        let count = seats.count
        
        updateBuyButtonLabel(for: count)
        if count > 0 {
            UIView.animate(withDuration: 0.25, animations: animateBuyButtonAppereance, completion: onBuyButtonAppeared)
        } else {
            UIView.animate(withDuration: 0.25, animations: animateBuyButtonDisappear)
        }
    }
    
    private func updateBuyButtonLabel(for tickets: Int) {
        guard tickets > 0 else { return }
        
        let price = 400 * tickets
        buyButton.setTitle("КУПИТЬ БИЛЕТЫ   ₽ \(price)", for: .normal)
    }
    
    private func animateBuyButtonAppereance() {
        guard buyButton.alpha != 1 else { return }
        
        buyButton.alpha = 1
        buyButton.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
    }
    
    private func animateBuyButtonDisappear() {
        buyButton.alpha = 0
    }
    
    private func onBuyButtonAppeared(_ success: Bool) {
        UIView.animate { self.buyButton.transform = .identity }
    }
}
