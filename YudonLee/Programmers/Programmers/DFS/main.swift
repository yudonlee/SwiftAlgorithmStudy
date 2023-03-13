//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2023/03/12.
//

import Foundation

func solution(_ n:Int, _ computers:[[Int]]) -> Int {
    var parents = (0...n).map { $0 }
    
    func findParent(idx: Int) -> Int {
        if parents[idx] == idx {
            return idx
        } else {
            parents[idx] = findParent(idx: parents[idx])
            return parents[idx]
        }
    }
    
    func unionParent(leftIdx: Int, rightIdx: Int) {
        let leftParent = findParent(idx: leftIdx)
        let rightParent = findParent(idx: rightIdx)
        if leftParent < rightParent {
            parents[rightParent] = leftParent
        } else if leftParent > rightParent {
            parents[leftParent] = rightParent
        }
    }
    
    for row in 0..<n {
        for col in 0..<n {
            if row != col, computers[row][col] == 1 {
                unionParent(leftIdx: row, rightIdx: col)
            }
        }
    }
    
    let result = (0..<n).filter { $0 == parents[$0] }
    return result.count
}

print(solution(3, [[1, 1, 0], [1, 1, 0], [0, 0, 1]]))
print(solution(3, [[1, 1, 0], [1, 1, 1], [0, 1, 1]]))

