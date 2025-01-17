//
//  Day10.swift
//
//
//  Created by Melissa Huang on 12/9/23.
//

import Foundation

fileprivate let input: [String] = FileLoader.load(file: "Day_10")!
public typealias Character = Swift.Character


public enum PipeType {
    case vert, horiz, el, jay, seven, eff, dot, ess
    
    public init(rawValue: Character) {
        switch rawValue {
        case "|": self = .vert
        case "-": self = .horiz
        case "L": self = .el
        case "J": self = .jay
        case "7": self = .seven
        case "F": self = .eff
        case ".": self = .dot
        case "S": self = .ess
        default: self = .dot
        }
    }
    
    var isValid: Bool {
        switch self {
        case .vert, .seven, .eff: true
        default: false
        }
    }
    
    func pipeTurn(toward: Direction) -> Direction {
        switch (self) {
        case .vert, .horiz:
            return toward
        case .el:
            return toward.el
        case .jay:
            return toward.jay
        case .seven:
            return toward.seven
        case .eff:
            return toward.eff
        default:
            return toward
        }
    }
}

public enum Direction {
    case north, east, south, west, nw, ne, sw, se
    
    public var offset: Point {
        switch self {
        case .north: Point(0, -1)
        case .west: Point(-1, 0)
        case .south: Point(0, 1)
        case .east: Point(1, 0)
        case .nw: Point(-1, -1)
        case .ne: Point(1, -1)
        case .sw: Point(-1, 1)
        case .se: Point(1, 1)
        }
    }
    //    | is a vertical pipe connecting north and south.      N
    //    - is a horizontal pipe connecting east and west.  W  J  L  E
    //    L is a 90-degree bend connecting north and east.     7  F
    //    J is a 90-degree bend connecting north and west.      S
    //    7 is a 90-degree bend connecting south and west.
    //    F is a 90-degree bend connecting south and east.
    public var jay: Direction {
        switch self {
        case .east: .north
        case .south: .west
        default: .south
        }
    }
        
    public var el: Direction {
        switch self {
        case .west: .north
        case .south: .east
        default: .south
        }
    }
    public var seven: Direction {
        switch self {
        case .east: .south
        case .north: .west
        default: .south
        }
    }
    public var eff: Direction {
        switch self {
        case .north: .east
        case .west: .south
        default: .south
        }
    }
        
}

public struct Day10Grid {
    public let points: [Point: Character]
    public let minX: Int
    public let maxX: Int
    public let minY: Int
    public let maxY: Int
    public let start: Point
    
    public var xRange: ClosedRange<Int> { minX ... maxX }
    public var yRange: ClosedRange<Int> { minY ... maxY }
        
    public init(start: Point, points: [Point: Character], minX: Int, maxX: Int, minY: Int, maxY: Int) {
        self.start = start
        self.points = points
        self.minX = minX
        self.maxX = maxX
        self.minY = minY
        self.maxY = maxY
    }
    
    
    public static func parse(_ data: [String]) -> Day10Grid {
        var points = [Point: Character]()
        var start = Point.zero
        
        for (y, line) in data.enumerated() {
            for (x, char) in line.enumerated() {
                let point = Point(x, y)
                if char == "S" {
                    start = point
                }
                points[point] = char as Character
            }
        }
        
        return Day10Grid(start: start, points: points,
                    minX: 0, maxX: data[0].count - 1,
                    minY: 0, maxY: data.count - 1)
    }
     
}

struct Day10: Day {

    func partOne() {
        let Day10Grid = Day10Grid.parse(input)
        let start = Day10Grid.start

        var nextPoint = start
        let allDirs: [Direction] = [.north, .east]
        // if this takes too long i'll have to take a step in each direction maybe
        // start by looking for a loop in one direction
        for (_, toward) in allDirs.enumerated() {
            var localTotal = 0
            var direction = toward
            // toward is the direction i'm moving in
            nextPoint = start + direction.offset
            var nextValue = Day10Grid.points[nextPoint]
            if nextValue == nil { continue }
            var pipeType = PipeType(rawValue: nextValue!)
            while nextPoint != start && pipeType != .dot {
                pipeType = PipeType(rawValue: nextValue!)
                direction = pipeType.pipeTurn(toward: direction)
                nextPoint = nextPoint + direction.offset
                nextValue = Day10Grid.points[nextPoint]
                localTotal += 1
            }
            if nextPoint == start {
                print("steps: \((localTotal + 1) / 2)")
                continue
            }
        }
    }
    
    func partTwo() {
        let Day10Grid = Day10Grid.parse(input)
        let start = Day10Grid.start
        var loopPipes = Set<Point>()
        var nextPoint = start
        loopPipes.insert(nextPoint)
        var direction = Direction.east
        // toward is the direction i'm moving in
        nextPoint = start + direction.offset
        var nextValue = Day10Grid.points[nextPoint]
        var pipeType = PipeType(rawValue: nextValue!)
        while nextPoint != start && pipeType != .dot {
            pipeType = PipeType(rawValue: nextValue!)
            loopPipes.insert(nextPoint)
            direction = pipeType.pipeTurn(toward: direction)
            nextPoint = nextPoint + direction.offset
            nextValue = Day10Grid.points[nextPoint]
        }
        
        var total = 0
        for y in (1...Day10Grid.maxY-1) {
            for x in (Day10Grid.minX...Day10Grid.maxX-1) {
                var count = 0
                if loopPipes.contains(Point(x, y)) {
                    continue
                }
                for countX in (x+1...Day10Grid.maxX) {
                    let countPoint = Point(countX, y)
                    let value = Day10Grid.points[countPoint]
                    let pipeType = PipeType(rawValue: value!)
                    if pipeType.isValid && loopPipes.contains(countPoint) {
                        count += 1
                    }
                }
                // if loop pipes is odd, counts as a total
                if !count.isMultiple(of: 2) {
                    total += 1
                }
            }
        }
        
        // first answer is 10
        print("answer2 is: \(total)")
    }
}
