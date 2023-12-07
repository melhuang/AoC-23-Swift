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
        case 3:
            return Day3()
        case 4:
            return Day4()
        case 5:
            return Day5()
        case 6:
            return Day6()
        case 7:
            return Day7()
        default:
            return Day1()
        }
    }
}
