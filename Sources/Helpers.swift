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
