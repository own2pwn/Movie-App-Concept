//
//  SeatType.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 03.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

public enum SeatType {
    case none, available, booked
    case spacing(CGFloat)
}

extension SeatType {
    var shouldRender: Bool {
        switch self {
        case .available, .booked:
            return true
        default:
            return false
        }
    }

    var spacing: CGFloat {
        switch self {
        case .spacing(let v):
            return v
        default:
            return 0
        }
    }

    var renderColor: UIColor {
        switch self {
        case .available:
            return #colorLiteral(red: 0.9266347289, green: 0.9417237639, blue: 0.9455887675, alpha: 1)
        case .booked:
            return #colorLiteral(red: 0.2550071478, green: 0.275069654, blue: 0.3003672957, alpha: 1)
        default:
            return .clear
        }
    }
}
