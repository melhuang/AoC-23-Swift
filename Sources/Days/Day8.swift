//
//  Day8.swift
//
//
//  Created by Melissa Huang on 12/7/23.
//

import Foundation

fileprivate let input: [String] = FileLoader.load(file: "Day_8")!

struct Day8: Day {
    enum Direction: String {
        case L, R
        
        public var value: Int {
            switch self {
            case .L:
                return 0
            case .R:
                return 1
            }
        }
    }

    let directions = Array(input.first!).map { Direction(rawValue: String($0)) }

    func makeTree(_ startingVals: inout [String]) -> Dictionary<String, [String]> {
        var dict = Dictionary<String, [String]>()
        var source = input
        source = Array(source[2...])
        
        for line in source {
            if line.isEmpty { break }
            let chunks = line.components(separatedBy: .whitespaces)
            let key = chunks[0]
            if key.hasSuffix("A") {
                startingVals.append(key)
            }
            let left = chunks[2].filter { $0.isLetter || $0.isNumber }
            let right = chunks[3].filter { $0.isLetter || $0.isNumber }
            
            dict[key] = [left, right]
        }
        return dict
    }
    
    func gcd(_ x: Int, _ y: Int) -> Int {
        var a = 0
        var b = max(x, y)
        var r = min(x, y)
        
        while r != 0 {
            a = b
            b = r
            r = a % b
        }
        return b
    }

    func lcm(_ x: Int, _ y: Int) -> Int {
        return x / gcd(x, y) * y
    }
    
    func partOne() {
        var startingVals = [String]()
        let tree = makeTree(&startingVals)
        var count = 0
        var target = false
        var nextVal: String = "AAA"
        while !target {
            let direction = directions[(count) % directions.count]!
            count += 1
            
            let intDirection = direction.value
            nextVal = tree[nextVal]![intDirection]
            
            if nextVal == "ZZZ" {
                target = true
            }
        }
        print("answer one: \(count)")
    }
    
    func partTwo() {
        var startingVals = [String]()
        let tree = makeTree(&startingVals)
        var counts = Array(repeating: 0, count: startingVals.count)
        for (index, startVal) in startingVals.enumerated() {
            var count = counts[index]
            var nextVal = startVal
            var target = false
            while !target {
                let direction = directions[(count) % directions.count]!
                count += 1
                
                let intDirection = direction.value
                nextVal = tree[nextVal]![intDirection]
                
                if nextVal.hasSuffix("Z") {
                    target = true
                }
            }
            counts[index] = count
        }
        
        var answer = 1
        for count in counts {
            answer = lcm(answer, count)
        }
        
        print("answer two: \(answer)")
    }
}
