//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2022/10/07.
//

import Foundation

func solution(_ progresses:[Int], _ speeds:[Int]) -> [Int] {
    var result: [Int] = []
    var dayCount = 0
    for (idx, unitProgress) in progresses.enumerated() {
        let dayChanged = Int(ceil(Double(100 - unitProgress) / Double(speeds[idx])))
        if dayCount >= dayChanged {
            result[result.count - 1] += 1
        } else {
            result.append(1)
            dayCount = dayChanged
        }
    }
    return result
}

print(solution([93, 30, 55], [1, 30, 5]))
print(solution([95, 90, 99, 99, 80, 99], [1, 1, 1, 1, 1, 1]))
print(solution([95, 90, 99, 99, 80, 99, 93, 30, 55], [1, 1, 1, 1, 1, 1, 1, 3, 4]))
