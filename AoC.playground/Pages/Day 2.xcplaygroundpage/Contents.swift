import Foundation

struct Round {
    let redCount: Int
    let greenCount: Int
    let blueCount: Int
    
    init(input: String) {
        if let match = input.firstMatch(of: /(\d+) red/) {
            redCount = Int(match.1)!
        } else {
            redCount = 0
        }
        
        if let match = input.firstMatch(of: /(\d+) green/) {
            greenCount = Int(match.1)!
        } else {
            greenCount = 0
        }
        
        if let match = input.firstMatch(of: /(\d+) blue/) {
            blueCount = Int(match.1)!
        } else {
            blueCount = 0
        }
    }
    
    func isValid(maxRed: Int, maxGreen: Int, maxBlue: Int) -> Bool {
        return redCount <= maxRed && greenCount <= maxGreen && blueCount <= maxBlue
    }
}

struct Game: Parseable {
    let id: Int
    let rounds: [Round]
    
    init(input: String) {
        let gameRange = input.ranges(of: /\d+/).first!
        id = Int(input[gameRange])!
        
        let prefixRange = input.ranges(of: try! Regex(#"Game \d+: "#)).first!
        rounds = input[prefixRange.upperBound...]
            .split(separator: ";")
            .map(String.init)
            .map(Round.init)
    }
    
    func isValid(maxRed: Int, maxGreen: Int, maxBlue: Int) -> Bool {
        return rounds.filter { !$0.isValid(maxRed: maxRed, maxGreen: maxGreen, maxBlue: maxBlue)}.count == 0
    }
    
    var fewestRedNeeded: Int {
        rounds.map(\.redCount).max() ?? 0
    }
    
    var fewestGreenNeeded: Int {
        rounds.map(\.greenCount).max() ?? 0
    }
    
    var fewestBlueNeeed: Int {
        rounds.map(\.blueCount).max() ?? 0
    }
    
    var power: Int {
        var total = 1
        
        if fewestRedNeeded != 0 {
            total *= fewestRedNeeded
        }
        
        if fewestGreenNeeded != 0 {
            total *= fewestGreenNeeded
        }
        
        if fewestBlueNeeed != 0 {
            total *= fewestBlueNeeed
        }
        
        return total
    }
}

let games: [Game] = FileLoader.load(file: "Day_2")

func partOne() {
    let sum = games.filter { $0.isValid(maxRed: 12, maxGreen: 13, maxBlue: 14)}
        .map(\.id)
        .reduce(0, +)
    
    print(sum)
}

func partTwo() {
    let sum = games.map { $0.power }.reduce(0, +)

    print(sum)
}

// partOne()
partTwo()
