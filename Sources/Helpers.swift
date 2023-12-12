//
//  Helpers.swift
//
//
//  Created by Melissa Huang on 12/5/23.
//

import Foundation

func getNumbers(from line: String) -> [Int] {
    return line.components(separatedBy: .whitespaces).compactMap { Int ($0) }
}

public struct Point: Hashable {
    public let x, y: Int
    
    public static let zero = Point(0, 0)
        
    public init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    public static func + (_ lhs: Point, _ rhs: Point) -> Point {
        Point(lhs.x + rhs.x, lhs.y + rhs.y)
    }
    
}

extension Point: CustomStringConvertible {
    public var description: String {
        "\(x),\(y)"
    }
}

public struct Grid {
    public let points: [Point: Character]
    public let minX: Int
    public let maxX: Int
    public let minY: Int
    public let maxY: Int
    
    public var xRange: ClosedRange<Int> { minX ... maxX }
    public var yRange: ClosedRange<Int> { minY ... maxY }
        
    public init(points: [Point: Character], minX: Int, maxX: Int, minY: Int, maxY: Int) {
        self.points = points
        self.minX = minX
        self.maxX = maxX
        self.minY = minY
        self.maxY = maxY
    }
    
    
    public static func parse(_ data: [String]) -> Grid {
        var points = [Point: Character]()
        
        for (y, line) in data.enumerated() {
            for (x, char) in line.enumerated() {
                let point = Point(x, y)
                points[point] = char as Character
            }
        }
        
        return Grid(points: points,
                    minX: 0, maxX: data[0].count - 1,
                    minY: 0, maxY: data.count - 1)
    }
     
}
