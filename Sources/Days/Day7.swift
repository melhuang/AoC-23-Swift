//
//  Day7.swift
//
//
//  Created by Melissa Huang on 12/6/23.
//

struct Day7: Day {
    
    enum HandType: String, Comparable {

        case five, four, full, three, twoPair, onePair, high
        
        private var sortOrder: Int {
            switch self {
            case .five:
                return 6
            case .four:
                return 5
            case .full:
                return 4
            case .three:
                return 3
            case .twoPair:
                return 2
            case .onePair:
                return 1
            case .high:
                return 0
            }
        }
        static func ==(lhs: HandType, rhs: HandType) -> Bool {
            return lhs.sortOrder == rhs.sortOrder
        }
        
        static func <(lhs: HandType, rhs: HandType) -> Bool {
            return lhs.sortOrder < rhs.sortOrder
        }
        
    }
    
    enum Rank: String, Comparable {
        
        private var sortOrder: Int {
            switch self {
            case .Two:
                return 0
            case .Three:
                return 1
            case .Four:
                return 2
            case .Five:
                return 3
            case .Six:
                return 4
            case .Seven:
                return 5
            case .Eight:
                return 6
            case .Nine:
                return 7
            case .T:
                return 8
            case .J:
                return 9
            case .Q:
                return 10
            case .K:
                return 11
            case .A:
                return 12
            }
        }
        
        static func < (lhs: Day7.Rank, rhs: Day7.Rank) -> Bool {
            return lhs.sortOrder < rhs.sortOrder
        }
        
        case Two, Three, Four, Five, Six, Seven, Eight, Nine, T, J, Q, K, A
        
        init?(rawValue: String) {
            switch rawValue {
            case "2":
                self = .Two
            case "3":
                self = .Three
            case "4":
                self = .Four
            case "5":
                self = .Five
            case "6":
                self = .Six
            case "7":
                self = .Seven
            case "8":
                self = .Eight
            case "9":
                self = .Nine
            case "T":
                self = .T
            case "J":
                self = .J
            case "Q":
                self = .Q
            case "K":
                self = .K
            case "A":
                self = .A
            default:
                return nil
            }
        }
    }
    
    struct Hand: Comparable {
        static func < (lhs: Day7.Hand, rhs: Day7.Hand) -> Bool {
            if lhs.handType == rhs.handType {
                let lhsArray = Array(lhs.string)
                let rhsArray = Array(rhs.string)
                for i in 0..<(lhsArray.count) {
                    let lhsChar = Rank(rawValue: String(lhsArray[i]))!
                    let rhsChar = Rank(rawValue: String(rhsArray[i]))!
                    if lhsChar == rhsChar {
                        continue
                    } else {
                        // if it's a j then
                        if lhsChar == .J {
                            return true
                        } else if rhsChar == .J {
                            return false
                        }
                        return lhsChar < rhsChar
                    }
                }
            } else {
                return lhs.handType < rhs .handType
            }
            return false
        }
        

        
        let string: String
        let bid: Int
        var handType: HandType = .high
            
        init(_ string: String, bid: Int) {
            self.string = string
            self.bid = bid
            
            var handArray = string.map { Rank(rawValue: String($0))! }
            
            func calculateJ() -> Rank {
                // handle Js
                let handArrayNoJs = handArray.filter { $0 != .J }.sorted(by: { $0 > $1 })
                
                let counts = Dictionary(grouping: handArrayNoJs, by: { $0 }).sorted(by: { $0.value.count > $1.value.count })
                
                return counts.first?.key ?? Rank.A
            }
            
            
            for i in 0..<string.count {
                let replacement = calculateJ()
                if handArray[i] == .J {
                    handArray[i] = replacement
                }
            }
            
            // get hand type
            var distinctVals = Set<Rank>()
            handArray.forEach { distinctVals.insert($0) }
                        
            // i want distinct vals
            switch distinctVals.count {
            case 1:
                self.handType = .five
            case 2:
                // if count of the first char is 1 or four, it's .four
                let charCount = handArray.filter { $0 == handArray[0] }.count
                if charCount == 1 || charCount == 4 {
                    self.handType = .four
                } else {
                    self.handType = .full
                }
            case 3:
                var set = false
                // if any of the first 3 chars have 3 occurrences, it's three of a kind
                for i in 0...2 {
                    let count = handArray.filter { $0 == handArray[i] }.count
                    if count == 3 {
                        self.handType = .three
                        set = true
                        break
                    }
                }
                if !set {
                    self.handType = .twoPair
                }
            case 4:
                self.handType = .onePair
            case 5:
                self.handType = .high
            default:
                assertionFailure("invalid hand")
                self.handType = .high
            }
        }
    }
    
    func partOne() {
        let input: [String] = FileLoader.load(file: "Day_7")!
        var hands = [Hand]()
        for line in input {
            if line.isEmpty { continue }
            let chunks = line.components(separatedBy: .whitespaces)
            let string = chunks[0]
            let bid = Int(chunks[1])!
            hands.append(Hand(string, bid: bid))
        }
        
        hands.sort()

        var total = 0
        for (index, hand) in hands.enumerated() {
            total += (index + 1) * hand.bid
        }
        print("answer: \(total)")
    }
    
    func partTwo() {
        let input: [String] = FileLoader.load(file: "Day_7")!
        var hands = [Hand]()
        for line in input {
            if line.isEmpty { continue }
            let chunks = line.components(separatedBy: .whitespaces)
            let string = chunks[0]
            let bid = Int(chunks[1])!
            let hand = Hand(string, bid: bid)
            hands.append(hand)
        }
        hands.sort()

        var total = 0
        for (index, hand) in hands.enumerated() {
            total += (index + 1) * hand.bid
        }
        print("answer: \(total)")
    }
}
