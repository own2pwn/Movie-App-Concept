//
//  SeatProvider.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 03.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

public final class SeatProvider {

    // MARK: - Members
    
    public static let shared = SeatProvider()
    
    // MARK: - Interface
    
    public func get() -> Stage {
        let l1b1 = Block<SeatType>(items: [.empty, .empty, .regular])
        let l1b2 = Block<SeatType>(items: [.empty, .regular, .regular, .regular, .regular, .empty])
        let l1b3 = Block<SeatType>(items: [.regular])
        
        let l1 = Line(seatBlocks: [l1b1, l1b2, l1b3])
        let lb1 = Block<Line>(items: [l1])
        let s1 = Stage(lineBlocks: [lb1])
        
        return s1
    }
}
