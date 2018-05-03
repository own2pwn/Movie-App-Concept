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
    
    public func get() -> SeatArray {
        let setSpacing: CGFloat = 4
        
        let booked = SeatType.booked
        let available = SeatType.available
        
        let none = SeatType.none
        let setSpace = SeatType.setSpace(setSpacing)
        let rowSpace = SeatType.rowSpace(setSpacing)
        
        let firstRow: [SeatType] = [none, none, available,
                                    setSpace, none,
                                    available, available, available, available,
                                    none, setSpace,
                                    available]
        
        let secondRow: [SeatType] = [none, available, available,
                                     setSpace, none,
                                     available, booked, available, available,
                                     none, setSpace,
                                     available, available, none]
        
        let thirdRow: [SeatType] = [available, available, available,
                                    setSpace, none,
                                    available, booked, booked, available,
                                    none, setSpace,
                                    available, available, available]
        
        let fullAvailable: [SeatType] = [available, available, available,
                                         setSpace, none,
                                         available, available, available, available,
                                         none, setSpace,
                                         available, available, available]
        
        let secondRowN: [SeatType] = [available, available, available,
                                      setSpace, none,
                                      available, booked, available, available,
                                      none, setSpace,
                                      available, available, available]
        
        let rows = [firstRow, secondRow, thirdRow, fullAvailable, fullAvailable]
        
        return rows
    }
}
