//
//  Logger.swift
//  rxBalance
//
//  Created by Evgeniy on 23.04.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import Foundation

typealias log = SwiftyBeaver

public final class Logger {
    static func setupLogging() {
        let console = ConsoleDestination()
        log.addDestination(console)
    }
}
