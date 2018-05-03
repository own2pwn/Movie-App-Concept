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
        let l1b1 = Block(seats: [.empty, .empty, .regular])
        let l1b2 = Block(seats: [.empty, .regular, .regular, .regular, .regular, .empty])
        let l1b3 = Block(seats: [.regular])
        
        let l1 = Line(type: .regular([l1b1, l1b2, l1b3]))
        let s1 = Stage(lines: [l1])
        
        return s1
    }
}
