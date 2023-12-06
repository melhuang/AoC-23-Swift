//
//  Day6.swift
//
//
//  Created by Melissa Huang on 12/4/23.
//

struct Day6: Day {
    private var input: [String] = FileLoader.load(file: "Day_6")!

    // distance = speed * time

    func partOne() {
        let times = input[0].components(separatedBy: .whitespaces)[1...].compactMap { Int($0) }
        let distances = input[1].components(separatedBy: .whitespaces)[1...].compactMap { Int($0) }
        
        var total = 1
        for i in 0..<times.count {
            let time = times[i]
            let goal = distances[i]

            var raceWays = 0
            for chargeTime in 1..<time-1 {
                let distanceTraveled = chargeTime * (time - chargeTime)
                if distanceTraveled > goal {
                    raceWays += 1
                }
            }
            
            if raceWays > 0 {
                total *= raceWays
            }
            raceWays = 0
        }
        print("part1 answer: \(total)")
    }

    func partTwo() {
        let times = input[0].components(separatedBy: .whitespaces)[1...].compactMap { Int($0) }
        let time = Int("\(times[0])\(times[1])\(times[2])\(times[3])")!
        let distances = input[1].components(separatedBy: .whitespaces)[1...].compactMap { Int($0) }
        let distance = Int("\(distances[0])\(distances[1])\(distances[2])\(distances[3])")!


        var raceWays = 0
        for chargeTime in 1..<time-1 {
            let distanceTraveled = chargeTime * (time - chargeTime)
            if distanceTraveled > distance {
                raceWays += 1
            }
        }
        print("part2 answer: \(raceWays)")
    }
}
