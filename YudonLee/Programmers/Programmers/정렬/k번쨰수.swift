//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2022/10/05.
//

import Foundation

import Foundation

func solution(_ array:[Int], _ commands:[[Int]]) -> [Int] {
    var result: [Int] = []
    commands.forEach { command in
        let start = command[0]
        let end = command[1]
        let idx = command[2] - 1
        let range = (start - 1)..<end
        var parsed = Array(array[range])
        parsed.sort()
        result.append(parsed[idx])
    }
    return result
}

print(solution([1, 5, 2, 6, 3, 7, 4], [[2, 5, 3], [4, 4, 1], [1, 7, 3]]))


