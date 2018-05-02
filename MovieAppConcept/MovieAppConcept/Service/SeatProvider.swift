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
    
    public func get() -> [[SeatType]] {
        let setSpacing: CGFloat = 4
        
        let booked = SeatType.booked
        let available = SeatType.available
        
        let none = SeatType.none
        let space = SeatType.spacing(setSpacing)
        
        let firstRow: [SeatType] = [none, none, available,
                                    space, none,
                                    available, available, available, available,
                                    none, space,
                                    available]
        
        let secondRow: [SeatType] = [available, available, available,
                                     space, none,
                                     available, booked, available, available,
                                     none, space,
                                     available, available, available]
        
        let rows = [firstRow, secondRow]
        
        return rows
    }
}
