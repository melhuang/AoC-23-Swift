struct Location: Hashable {
    let x: Int
    let y: Int
}

struct Schematic {
    private let input: [[Character]]

    init(input: [String]) {
        self.input = input.map(Array.init)
    }

    func firstPartSum() -> Int {
        var sum = 0

        for (rowIndex, row) in input.enumerated() {
            var numberCharacters = [Character]()

            for (characterIndex, character) in row.enumerated() {
                if character.isNumber {
                    numberCharacters.append(character)

                    if characterIndex == row.count - 1 {
                        if isAdjacentToSymbol(
                            row: rowIndex,
                            startIndex: characterIndex - numberCharacters.count + 1,
                            length: numberCharacters.count
                        ) {
                            sum += Int(String(numberCharacters))!
                        }

                        numberCharacters.removeAll()
                    }

                } else {
                    if !numberCharacters.isEmpty {
                        if isAdjacentToSymbol(
                            row: rowIndex,
                            startIndex: characterIndex - numberCharacters.count,
                            length: numberCharacters.count
                        ) {
                            sum += Int(String(numberCharacters))!
                        }

                        numberCharacters.removeAll()
                    }
                }
            }
        }

        return sum
    }

    func secondPartSum() -> Int {
        var gears = [Location: [Int]]()

        for (rowIndex, row) in input.enumerated() {
            var numberCharacters = [Character]()

            for (characterIndex, character) in row.enumerated() {
                if character.isNumber {
                    numberCharacters.append(character)

                    if characterIndex == row.count - 1 {
                        if let location = adjacentGear(
                            row: rowIndex,
                            startIndex: characterIndex - numberCharacters.count + 1,
                            length: numberCharacters.count
                        ) {
                            let part = Int(String(numberCharacters))!
                            gears[location] == nil
                                ? gears[location] = [part] : gears[location]?.append(part)
                        }

                        numberCharacters.removeAll()
                    }

                } else {
                    if !numberCharacters.isEmpty {
                        if let location = adjacentGear(
                            row: rowIndex, startIndex: characterIndex - numberCharacters.count,
                            length: numberCharacters.count)
                        {
                            let part = Int(String(numberCharacters))!
                            gears[location] == nil
                                ? gears[location] = [part] : gears[location]?.append(part)
                        }

                        numberCharacters.removeAll()
                    }
                }
            }
        }

        gears.forEach { print("x: \($0.key.x) y: \($0.key.y) numbers: \($0.value)") }

        return gears.values.filter { $0.count == 2 }.map { $0.reduce(1, *) }.reduce(0, +)
    }

    func adjacentGear(row: Int, startIndex: Int, length: Int) -> Location? {
        // Leading character check
        if startIndex != 0 && input[row][startIndex - 1].isGear {
            return Location(x: startIndex - 1, y: row)
        }

        // Trailing character check
        if startIndex + length < input[row].count - 1
            && input[row][startIndex + length].isGear
        {
            return Location(x: startIndex + length, y: row)
        }

        if row > 0 {
            let leftIndex = if startIndex == 0 { 0 } else { startIndex - 1 }

            let rightIndex =
                if startIndex + length == input[row].count {
                    input[row].count - 1
                } else {
                    startIndex + length
                }

            for index in leftIndex...rightIndex {
                if input[row - 1][index].isGear {
                    return Location(x: index, y: row - 1)
                }
            }
        }

        // Bottom row check
        if row < input.count - 1 {
            let leftIndex = if startIndex == 0 { 0 } else { startIndex - 1 }

            let rightIndex =
                if startIndex + length == input[row].count {
                    input[row].count - 1
                } else {
                    startIndex + length
                }

            for index in leftIndex...rightIndex {
                if input[row + 1][index].isGear {
                    return Location(x: index, y: row + 1)
                }
            }
        }

        return nil
    }

    func isAdjacentToSymbol(row: Int, startIndex: Int, length: Int) -> Bool {
        // Leading character check
        if startIndex != 0 && input[row][startIndex - 1].isSymbol {
            return true
        }

        // Trailing character check
        if startIndex + length < input[row].count - 1
            && input[row][startIndex + length].isSymbol
        {
            return true
        }

        // Top row check
        if row > 0 {
            let leftIndex = if startIndex == 0 { 0 } else { startIndex - 1 }

            let rightIndex =
                if startIndex + length == input[row].count {
                    input[row].count - 1
                } else {
                    startIndex + length
                }

            for index in leftIndex...rightIndex {
                if input[row - 1][index].isSymbol {
                    return true
                }
            }
        }

        // Bottom row check
        if row < input.count - 1 {
            let leftIndex = if startIndex == 0 { 0 } else { startIndex - 1 }

            let rightIndex =
                if startIndex + length == input[row].count {
                    input[row].count - 1
                } else {
                    startIndex + length
                }

            for index in leftIndex...rightIndex {
                if input[row + 1][index].isSymbol {
                    return true
                }
            }
        }

        return false
    }
}

extension Character {
    var isSymbol: Bool {
        !self.isNumber && self != "."
    }

    var isGear: Bool {
        self == "*"
    }
}

struct Day3: Day {
    private let schematic = Schematic(input: FileLoader.load(file: "Day_3")!)

    func partOne() {
        print(schematic.firstPartSum())
    }

    func partTwo() {
        print(schematic.secondPartSum())
    }
}

// we need to figure out the numbers
// thren we need to have to have a function that determines if anything is around the numbers
