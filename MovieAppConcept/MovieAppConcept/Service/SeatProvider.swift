//
//  SeatProvider.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 03.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

public typealias JSONObject = [String: Any]

public final class SeatProvider {

    // MARK: - Members
    
    public static let shared = SeatProvider()
    
    // MARK: - Interface
    
    public func get() -> Stage {
        let lineBlocks = getLines()
        var lines: [Line] = []
        
        for lineBlock in lineBlocks {
            guard let seatBlocks = lineBlock["seatBlocks"] as? [[String]] else { continue }
            
            var seatBlockArray: [Block<SeatType>] = []
            
            for block in seatBlocks {
                var seatTypes: [SeatType] = []
                
                for seat in block {
                    let seatType = SeatType(rawValue: seat)!
                    seatTypes.append(seatType)
                }
                let newBlock = Block<SeatType>(items: seatTypes)
                seatBlockArray.append(newBlock)
            }
            
            let newLine = Line(seatBlocks: seatBlockArray)
            lines.append(newLine)
        }
        
        // let l1b1 = Block<SeatType>(items: [.empty, .empty, .regular])
        // let l1b2 = Block<SeatType>(items: [.empty, .regular, .regular, .regular, .regular, .empty])
        // let l1b3 = Block<SeatType>(items: [.regular])
        //
        // let l1 = Line(seatBlocks: [l1b1, l1b2, l1b3])
        // let lb1 = Block<Line>(items: [l1])
        // let s1 = Stage(lineBlocks: [lb1])
        
        let lb1 = Block<Line>(items: lines)
        let s1 = Stage(lineBlocks: [lb1])
        
        return s1
    }
    
    // MARK: - Internal
    
    private func getLines() -> [JSONObject] {
        let json = getJSON()
        guard let stages = json["stages"] as? [JSONObject],
            let stage = stages.first,
            let lineBlocks = stage["lineBlocks"] as? [JSONObject] else { fatalError() }
        
        return lineBlocks
    }
    
    private func getJSON() -> JSONObject {
        guard let modelURL = Bundle.main.url(forResource: "Model", withExtension: "json"),
            let data = try? Data(contentsOf: modelURL),
            let object = try? JSONSerialization.jsonObject(with: data, options: []),
            let json = object as? JSONObject else { fatalError() }
        
        return json
    }
}
