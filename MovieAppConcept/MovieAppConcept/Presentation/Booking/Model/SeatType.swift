//
//  SeatType.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 03.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

public typealias SeatArray = [[SeatType]]

public enum LineType {
    case normal([BlockType])
    case empty
}

public enum BlockType {
    case normal([SeatType_])
    case empty
}

public enum SeatType_ {
    case normal, booked
    case empty
}

public struct Stage {
    let lines: [Line]
}

public struct Line {
    let type: LineType
}

public struct Block {
    let type: BlockType
}

public struct Seat {
    let type: SeatType_
}

final class Test {
    func provider() {
        let b1 = BlockType.normal([.empty, .empty, .normal])
        let b2 = BlockType.empty
    }
}

public struct SeatLine {
    let seats: [SeatType_]
    let spacing: CGFloat
}

public struct SeatBlock {
    let seats: [SeatModel]
    let spacing: CGFloat
}

public struct SeatModel {
    let type: SeatType_
    let spacing: CGFloat
}

public enum SeatType {
    case none, emptyRow, available, booked
    case setSpace(CGFloat), rowSpace(CGFloat)
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
        case .setSpace(let v), .rowSpace(let v):
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

    var isEnabled: Bool {
        switch self {
        case .available:
            return true
        default:
            return false
        }
    }
}
