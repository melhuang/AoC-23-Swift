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
}

struct Day3: Day {
    private let schematic = Schematic(input: FileLoader.load(file: "Day_3")!)

    func partOne() {
        print(schematic.firstPartSum())
    }

    func partTwo() {
        print("Part 2")
    }
}

// we need to figure out the numbers
// thren we need to have to have a function that determines if anything is around the numbers
