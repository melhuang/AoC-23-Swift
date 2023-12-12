//
//  Day11.swift
//
//
//  Created by Melissa Huang on 12/11/23.
//

import Foundation

fileprivate let input: [String] = FileLoader.load(file: "Day_11")!

struct Day11: Day {
    func partOne() {
        let grid = Grid.parse(input)
        var emptyRows = [Int]()
        var emptyCols = [Int]()
        for i in (grid.minX..<grid.maxX) {
            var chars = [Character]()
            for row in (grid.minY...grid.maxY-1) {
                chars.append(grid.points[Point(i, row)]!)
            }
            if (chars.filter { $0 != "."}.isEmpty) { emptyCols.append(i) }
        }
        var galaxies = [Point]()
        for i in (grid.minY...grid.maxY-1) {
            let string = input[i]
            if (string.filter { $0 != "."}.isEmpty) { emptyRows.append(i) }
            for (index, char) in Array(string).enumerated() {
                if char == "#" {
                    let point = Point(index, i)
                    galaxies.append(point)
                }
            }
        }
        var total = 0
        for (index, galaxy) in galaxies.enumerated() {
            if index == galaxies.count - 1 { break }
            let start = galaxy
            for i in ((index+1)..<(galaxies.count)) {
                let dest = galaxies[i]
                let distance = abs(dest.x - start.x) + (dest.y - start.y)
                total += distance
                let minX = min(start.x, dest.x)
                let maxX = max(start.x, dest.x)
                for x in minX..<maxX {
                    if emptyCols.contains(x) {
                        total += 999999
                    }
                }
                for y in start.y..<dest.y {
                    if emptyRows.contains(y) {
                        total += 999999
                    }
                }
            }
        }
                
        print("answer1 is: \(total)")
    }

    func partTwo() {
        var total = 0
        print("answer2 is: \(total)")
    }
}
