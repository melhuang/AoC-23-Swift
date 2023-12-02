import AoC_Sources

let results = FileLoader.load(file: "Day_1")!


func partOne() {
    var total = 0

    for string in results {
        guard !string.isEmpty else { continue }

        let firstNumber = string.first { $0.isNumber }!
        let lastNumber = string.last { $0.isNumber }!
        
        total += Int(String(firstNumber) + String(lastNumber))!
    }

    print(total)
}

func partTwo() {
    var total = 0
    var possibilities = [
        "1": "1",
        "2": "2",
        "3": "3",
        "4": "4",
        "5": "5",
        "6": "6",
        "7": "7",
        "8": "8",
        "9": "9",
        "one": "1",
        "two": "2",
        "three": "3",
        "four": "4",
        "five": "5",
        "six": "6",
        "seven": "7",
        "eight": "8",
        "nine": "9"
    ]

    for string in results {
        guard !string.isEmpty else { continue }

        let firstNumber = firstValue(word: string)
        let lastNumber = lastValue(word: string)
        
        print("Value: \(string) result: \(String(firstNumber) + String(lastNumber))")

        total += Int(String(firstNumber) + String(lastNumber))!
    }
    
    print(total)
    
    func firstValue(word: String) -> Character {
        let keys = possibilities.keys
        var lowestIndex: Int?
        var lowestKey: String?
        
        for key in keys {
            if let firstIndex = word.firstIndex(of: key) {
                if let index = lowestIndex {
                    if firstIndex < index {
                        lowestIndex = firstIndex
                        lowestKey = key
                    }
                } else {
                    lowestIndex = firstIndex
                    lowestKey = key
                }
            }
        }
        
        return possibilities[lowestKey!]!.first!
    }
    
    func lastValue(word: String) -> Character {
        let keys = possibilities.keys
        var highestIndex: Int?
        var highestKey: String?
        
        for key in keys {
            if let firstIndex = word.lastIndex(of: key) {
                // print("key \(key) first index \(firstIndex) highest index \(highestIndex)")
                if let index = highestIndex {
                    if firstIndex > index {
                        highestIndex = firstIndex
                        highestKey = key
                    }
                } else {
                    highestIndex = firstIndex
                    highestKey = key
                }
            }
        }
        
        return possibilities[highestKey!]!.first!
    }
}

extension String {
    func firstIndex(of value: String) -> Int? {
        guard let index = self.firstRange(of: value)?.lowerBound else { return nil }
        return self.distance(from: self.startIndex, to: index)
    }
    
    func lastIndex(of value: String) -> Int? {
        let ranges = self.ranges(of: try! Regex(value))
        guard !ranges.isEmpty else { return nil }
        let maxRange = ranges.sorted(by: { $0.upperBound < $1.upperBound }).last!
        return self.distance(from: self.startIndex, to: maxRange.upperBound)
    }
}

partTwo()

