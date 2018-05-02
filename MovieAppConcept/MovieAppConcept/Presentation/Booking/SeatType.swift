//
//  SeatType.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 03.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

enum SeatType {
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
            return #colorLiteral(red: 0.2197602093, green: 0.3824803233, blue: 0.4539470673, alpha: 1)
        case .booked:
            return #colorLiteral(red: 0.7422102094, green: 0.764362216, blue: 0.7821244597, alpha: 1)
        default:
            return .clear
        }
    }
}
