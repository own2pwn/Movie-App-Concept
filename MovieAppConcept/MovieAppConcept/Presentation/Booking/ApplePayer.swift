//
//  ApplePayer.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 04.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import PassKit
import UIKit

public final class ApplePayer: NSObject, PKPaymentAuthorizationControllerDelegate {

    // MARK: - Interface
    
    public func presentOverlay(for tickets: Int, ticketPrice: Int, movie: String) {
        let items = pickedTickets(tickets, price: ticketPrice, movie: movie)
        presentPaymentOverlay(for: items)
    }
    
    // MARK: - Internal
    
    private func presentPaymentOverlay(for tickets: [PKPaymentSummaryItem]) {
        let paymentNetworks: [PKPaymentNetwork] = [.visa, .masterCard]
        guard PKPaymentAuthorizationController.canMakePayments(usingNetworks: paymentNetworks) else { return }
        
        let request = PKPaymentRequest()
        
        request.merchantIdentifier = "own2pwn.pp.cinema"
        request.countryCode = "RU"
        request.currencyCode = "RUB"
        request.supportedNetworks = paymentNetworks
        request.merchantCapabilities = .capability3DS
        request.paymentSummaryItems = tickets
        
        let paymentOverlay = PKPaymentAuthorizationController(paymentRequest: request)
        paymentOverlay.delegate = self
        paymentOverlay.present(completion: nil)
    }
    
    private func pickedTickets(_ count: Int, price: Int, movie: String) -> [PKPaymentSummaryItem] {
        let ticket: PKPaymentSummaryItem
        if count > 1 {
            ticket = processMultipleTicket(price, count: count, movie: movie)
        } else {
            ticket = processSingleTicket(price, movie: movie)
        }
        
        return [ticket]
    }
    
    private func processSingleTicket(_ price: Int, movie: String) -> PKPaymentSummaryItem {
        return PKPaymentSummaryItem(label: "\(movie.capitalized) Ticket", amount: NSDecimalNumber(value: price), type: .final)
    }
    
    private func processMultipleTicket(_ price: Int, count: Int, movie: String) -> PKPaymentSummaryItem {
        return PKPaymentSummaryItem(label: "\(movie.capitalized) Tickets (\(count)x)", amount: NSDecimalNumber(value: price * count), type: .final)
    }
    
    // MARK: - PKPaymentAuthorizationControllerDelegate
    
    public func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        let result = PKPaymentAuthorizationResult(status: .success, errors: nil)
        completion(result)
    }
    
    public func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss(completion: nil)
    }
}
