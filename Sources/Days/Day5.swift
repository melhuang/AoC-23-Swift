//
//  Day5.swift
//  
//
//  Created by Melissa Huang on 12/4/23.
//

struct Day5: Day {
    private var input: [String] = FileLoader.load(file: "Day_5")!
    
    struct MapRange {
        let dest: Int
        let source: Int
        let length: Int
        
        func isValidSource(_ input: Int) -> Bool {
            return (source..<source+length).contains(input)
        }
        
        func result(input: Int) -> Int {
            let diff = input - source
            return dest + diff
        }
        
    }
    

    func partOne() {
//        var lines = input
//        let seeds: [Int] = input.first!.components(separatedBy: .whitespaces).compactMap { Int($0) }
//        print(lines.count)
//
//        var locations = [Int]()
//        for seed in seeds {
//            lines = Array(input[3...])
//
//            // seed to soil
//            let (soil, trim) = computeValue(input: lines, seed: seed)
//            lines = Array(lines[(trim)...])
//
//            // soil to fert
//
//            let (fert, trim2) = computeValue(input: lines, seed: soil)
//            lines = Array(lines[(trim2)...])
//            
//            // fert to water
//            let (water, trim3) = computeValue(input: lines, seed: fert)
//            
//            lines = Array(lines[(trim3)...])
//            
//            // water to light
//            let (light, trim4) = computeValue(input: lines, seed: water)
//            
//            lines = Array(lines[(trim4)...])
//            
//            // light to temp
//            let (temp, trim5) = computeValue(input: lines, seed: light)
//            
//            lines = Array(lines[(trim5)...])
//            
//            // temp to humid
//            let (humid, trim6) = computeValue(input: lines, seed: temp)
//            
//            lines = Array(lines[(trim6)...])
//            
//            // humid to loc
//            let (loc, _) = computeValue(input: lines, seed: humid)
//            
//            locations.append(loc)
//        }
//        print("\(locations.min()!)")
    }

    func computeValue(_ nextRanges: [MapRange], _ seed: Int) -> Int {
        var nextValue: Int = -1
        for range in nextRanges {
            if range.isValidSource(seed) {
                nextValue = range.result(input: seed)
                break
            }
        }
        if nextValue == -1 {
            nextValue = seed
        }
        return nextValue
    }
    
    func findNextRanges(input: [String]) -> [MapRange] {
        func isAllNums(_ allNums: String) -> Bool {
            return Array(allNums)[0].isNumber
        }
        var output = [MapRange]()
        
        for line in input {
            if Array(line).isEmpty { break }
            if Array(line).first!.isWhitespace { break }
            if isAllNums(line) {
                let nums = line.components(separatedBy: .whitespaces).compactMap { Int ($0) }
                output.append(MapRange(dest: nums[1], source: nums[0], length: nums[2]))
            }
        }
        return output
    }

    func partTwo() {
        var lines = input
        let seedInts: [Int] = input.first!.components(separatedBy: .whitespaces).compactMap { Int($0) }
//        var seeds = Set<Int>()
//        while !seedRanges.isEmpty {
//            for i in seedRanges[0]..<(seedRanges[0] + seedRanges[1]) {
//                seeds.insert(i)
//            }
//            if seedRanges.count == 2 {
//                break
//            }
//            seedRanges = Array(seedRanges[2...])
//            print("chopped")
//            print(seedRanges.count)
//        }
        
        var soils = [MapRange]()
        var ferts = [MapRange]()
        var waters = [MapRange]()
        var lights = [MapRange]()
        var temps = [MapRange]()
        var humids = [MapRange]()
        var locs = [MapRange]()
        
        func findRanges() {
            lines = Array(input[3...])
            
            soils = findNextRanges(input: lines)
            
            lines = Array(lines[(soils.count+2)...])
            
            ferts = findNextRanges(input: lines)
            
            lines = Array(lines[(ferts.count+2)...])
            
            print("finished ferts")

            waters = findNextRanges(input: lines)
            
            lines = Array(lines[(waters.count+2)...])
            
            lights = findNextRanges(input: lines)
            
            lines = Array(lines[(lights.count+2)...])
            
            temps = findNextRanges(input: lines)
            
            lines = Array(lines[(temps.count+2)...])
            
            humids = findNextRanges(input: lines)
            
            print("finished humids")

            lines = Array(lines[(humids.count+2)...])

            locs = findNextRanges(input: lines).sorted(by: { range1, range2 in
                range1.source < range2.source
            })
            print("finished locs")
        }
        
        findRanges()
        
        func findSeed(for loc: Int) -> Int {
            if (loc == 46) {
                
            }
            // humid from loc
            let humid = computeValue(locs, loc)
            
            // temp from humid
            let temp = computeValue(humids, humid)

            // light from temp
            let light = computeValue(temps, temp)

            // water from light
            let water = computeValue(lights, light)
            
            // fert from water
            let fert = computeValue(waters, water)
                    
            // soil from fert
            let soil = computeValue(ferts, fert)
            
            // seed from soil
            let seed = computeValue(soils, soil)
            
            return seed
        }
        
        let last = locs.last!
        
        func isValidSeed(_ seed: Int) -> Bool {
            var tempSeeds = seedInts
            while !tempSeeds.isEmpty {
                if tempSeeds.count == 2 {
                    return false
                }
                if seed >= tempSeeds[0] && seed < (tempSeeds[0] + tempSeeds[1]) {
                    return true
                }
                tempSeeds = Array(tempSeeds[2...])
            }
            return false
        }

        for i in 0..<(last.dest + last.length) {
            if i%1000 == 0 { print("checking location: \(i)") }
            if isValidSeed(findSeed(for: i)) {
                print("answer!!!")
                print(i)
                exit(0)
            }
        }
    }
}
