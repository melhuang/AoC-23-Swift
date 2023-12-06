//
//  Day4.swift
//  
//
//  Created by Melissa Huang on 12/4/23.
//

import Foundation

struct Day4: Day {
    let lineArray = FileLoader.load(file: "Day_4")!.map { $0.components(separatedBy: ":").last! }

    func partOne() {
        var total = 0
        for line in lineArray {
            var winningNums = [Int]()
            var myNums = [Int]()
            var matchCount = 0
            
            let split: [String] = line.components(separatedBy: "|").map { String($0) }

            winningNums = split.first!.components(separatedBy: .whitespaces).compactMap { Int($0) }

            myNums = split.last!.components(separatedBy: .whitespaces).compactMap { Int($0) }
            
            for num in myNums {
                if winningNums.contains(where: { $0 == num }) {
                    matchCount += 1
                }
            }
            if matchCount > 0 {
                let power = matchCount - 1
                let intTotal = NSDecimalNumber(decimal: pow(2, power))
                total += Int(truncating: intTotal)
            }
        }
        print("answer: \(total)")
    }

    func getMatchCount(line: String) -> Int {
        var winningNums = [Int]()
        var myNums = [Int]()
        var matchCount = 0
        
        let split: [String] = line.components(separatedBy: "|").map { String($0) }

        winningNums = split.first!.components(separatedBy: .whitespaces).compactMap { Int($0) }

        myNums = split.last!.components(separatedBy: .whitespaces).compactMap { Int($0) }
        
        for num in myNums {
            if winningNums.contains(where: { $0 == num }) {
                matchCount += 1
            }
        }
        return matchCount
    }
    
    func partTwo() {
        var dict = [Int: Int]()
        var cards = lineArray.count

        for (index, line) in lineArray.enumerated() {
            dict[index] = getMatchCount(line: line)
        }
        func addUntilZero(i: Int) {
            if dict[i] == 0 {
                return
            } else {
                let matchNumber = dict[i] ?? 0
                cards += matchNumber
                for j in 1...matchNumber {
                    addUntilZero(i: i + j)
                }
            }
        }
        
        for (cardNumber, _) in dict {
            addUntilZero(i: cardNumber)
        }
        
        print("answer: \(cards)")
    }
}
