//
//  SeatType.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 03.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

public struct Stage {
    let lineBlocks: [Block<Line>]
}

public struct Line {
    let seatBlocks: [Block<SeatType>]
}

public struct Block<Element> {
    let items: [Element]
}

public enum LineType {
    case regular([Block<SeatType>])
    case empty
}

public enum SeatType: String {
    case regular, booked
    case empty
}

protocol Renderable {
    var shouldRender: Bool { get }
}

extension LineType: Renderable {
    var shouldRender: Bool {
        switch self {
        case .regular:
            return true
        default:
            return false
        }
    }

    var seatBlocks: [Block<SeatType>] {
        switch self {
        case .regular(let blocks):
            return blocks
        default:
            return []
        }
    }
}

extension SeatType: Renderable {
    var shouldRender: Bool {
        return self == .regular ||
            self == .booked
    }

    var renderColor: UIColor {
        switch self {
        case .regular:
            return #colorLiteral(red: 0.9266347289, green: 0.9417237639, blue: 0.9455887675, alpha: 1)
        case .booked:
            return #colorLiteral(red: 0.2550071478, green: 0.275069654, blue: 0.3003672957, alpha: 1)
        default:
            return .clear
        }
    }

    var isEnabled: Bool {
        return self == .regular
    }
}
