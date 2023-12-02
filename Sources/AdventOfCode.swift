//
//  AdventOfCode.swift
//
//
//  Created by Michael Fransen on 12/2/23.
//

import ArgumentParser
import Foundation

@main
struct AdventOfCode: ParsableCommand {
    @Argument(help: "The day to run.")
    var dayNumber: Int
    
    @Argument(help: "The part to run.")
    var part: Int
    
    func run() throws {
        switch part {
        case 1:
            day.partOne()
        case 2:
            day.partTwo()
        default:
            fatalError("You specified an invalid day.")
        }
    }
    
    private var day: Day {
        switch dayNumber {
        case 1:
            return Day1()
        case 2:
            return Day2()
        default:
            return Day1()
        }
    }
}
