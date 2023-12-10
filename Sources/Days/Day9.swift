//
//  Day9.swift
//
//
//  Created by Melissa Huang on 12/8/23.
//

import Foundation

fileprivate let input: [String] = FileLoader.load(file: "Day_9")!

struct Day9: Day {
    
    func getInput(reversed: Bool = false) -> [[Int]] {
        var output = [[Int]]()
        for line in input {
            var nums = line.components(separatedBy: .whitespaces).compactMap { Int($0) }
            if reversed { nums.reverse() }
            if !nums.isEmpty { output.append(nums) }
        }
        return output
    }
    
    func isAllZero(_ input: [Int]) -> Bool {
        return input.filter { $0 != 0 }.isEmpty
    }
    
    func partOne() {
        let lines = getInput()
        var total = 0
        for line in lines {
            var nextLine = line
            var tiers = [[Int]]()
            tiers.append(line)
            while !isAllZero(nextLine) {
                nextLine = zip(nextLine, nextLine.dropFirst()).map { $1 - $0 }
                tiers.append(nextLine)
            }
            tiers.reverse()
            var last = 0
            for i in 0..<tiers.count {
                last = tiers[i].last! + last
                tiers[i].append(last)
            }
            total += tiers.last!.last!
        }
        print("answer1 is: \(total)")
    }
    
    func partTwo() {
        let lines = getInput(reversed: true)
        var total = 0
        for line in lines {
            var nextLine = line
            var tiers = [[Int]]()
            tiers.append(line)
            while !isAllZero(nextLine) {
                nextLine = zip(nextLine, nextLine.dropFirst()).map { $1 - $0 }
                tiers.append(nextLine)
            }
            tiers.reverse()
            var last = 0
            for i in 0..<tiers.count {
                last = tiers[i].last! + last
                tiers[i].append(last)
            }
            total += tiers.last!.last!
        }
        print("answer2 is: \(total)")
    }
}
