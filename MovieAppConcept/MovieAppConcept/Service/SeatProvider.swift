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
        
        let emptyLineBlock = Block<Line>(items: [])
        
        let b1 = Array(lines[0..<5])
        let lb1 = Block<Line>(items: b1)
        
        let b2 = Array(lines[5..<8])
        let lb2 = Block<Line>(items: b2)
        
        let b3 = Array(lines[8..<12])
        let lb3 = Block<Line>(items: b3)
        
        let s1 = Stage(lineBlocks: [lb1, emptyLineBlock, lb2, emptyLineBlock, lb3])
        
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
