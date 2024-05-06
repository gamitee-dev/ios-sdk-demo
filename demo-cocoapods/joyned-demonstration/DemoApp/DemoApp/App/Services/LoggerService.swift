//
//  LoggerService.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 03/12/2023.
//
import XCGLogger
///
///
///
let loggerID = Bundle.main.bundleIdentifier!
///
///
///
let logger : XCGLogger = {
    
    let logger = XCGLogger(identifier: loggerID, includeDefaultDestinations: false)
    logger.add(destination: LoggerDestinations.consoleDestination)
    // logger.add(destination: LoggerDestinations.crashlyticsDestination)
    logger.logAppDetails()
    
    return logger
}()

struct LoggerDestinations
{
    private init() {}
    
    // MARK: - XCGLogger Destinations
    static var     consoleDestination : BaseQueuedDestination {
        
        let identifier  = "\(loggerID).console"
        let destination = ConsoleDestination(identifier: identifier)
        destination.outputLevel          = .debug
        destination.showLogIdentifier    = false
        destination.showFunctionName     = true
        destination.showThreadName       = false
        destination.showLevel            = true
        destination.showFileName         = true
        destination.showLineNumber       = true
        destination.showDate             = true
        destination.logQueue             = DispatchQueue(label: "\(identifier).queue", qos: .`default`)
        return destination
    }
    // static var crashlyticsDestination : BaseQueuedDestination {
    //     let identifier  = "\(loggerID).crashlytics"
    //     let destination = CrashlyticsDestination(identifier: identifier)
    //     destination.outputLevel         = .debug
    //     destination.showLogIdentifier   = false
    //     destination.showFunctionName    = true
    //     destination.showThreadName      = false
    //     destination.showLevel           = true
    //     destination.showFileName        = true
    //     destination.showLineNumber      = true
    //     destination.showDate            = true
    //     destination.logQueue            = DispatchQueue(label: "\(identifier).queue", qos: .`default`)
    //     return destination
    // }
}
