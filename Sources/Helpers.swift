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
