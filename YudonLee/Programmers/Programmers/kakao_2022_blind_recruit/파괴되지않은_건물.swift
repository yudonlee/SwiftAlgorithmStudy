//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2022/09/18.
//

import Foundation

func solution(_ board:[[Int]], _ skill:[[Int]]) -> Int {
    var board = board
    var result = 0
    let N = board.map { $0 }.count
    let M = board[0].count
    
    var degrees: [[Int]] = Array(repeating: Array(repeating: 0, count: M + 1), count: N + 1)
    
    skill.forEach { query in
        let multi = query[0] == 1 ? -1 : 1
        
        degrees[query[1]][query[2]] += query[5] * multi
        degrees[query[1]][query[4] + 1] += query[5] * multi * -1
        degrees[query[3] + 1][query[2]] += query[5] * multi * -1
        degrees[query[3] + 1][query[4] + 1] += query[5] * multi
        
    }
    
    var horizontalPrefixSum: [[Int]] = Array(repeating: Array(repeating: 0, count: M), count: N)
    for y in 0..<N {
        horizontalPrefixSum[y][0] = degrees[y][0]
        for x in 1..<M {
            horizontalPrefixSum[y][x] = horizontalPrefixSum[y][x - 1] + degrees[y][x]
        }
    }
    
    var prefixSum: [[Int]] = Array(repeating: Array(repeating: 0, count: M), count: N)
    for x in 0..<M {
        prefixSum[0][x] = horizontalPrefixSum[0][x]
        for y in 1..<N {
            prefixSum[y][x] = prefixSum[y - 1][x] + horizontalPrefixSum[y][x]
        }
    }
    
    for y in 0..<N {
        for x in 0..<M {
            if board[y][x] + prefixSum[y][x] > 0 {
                result += 1
            }
        }
    }
    
    
    
    return result
}

print(solution([[5, 5, 5, 5, 5], [5, 5, 5, 5, 5], [5, 5, 5, 5, 5], [5, 5, 5, 5, 5]], [[1, 0, 0, 3, 4, 4], [1, 2, 0, 2, 3, 2], [2, 1, 0, 3, 1, 2], [1, 0, 1, 3, 3, 1]]))
print(solution([[1, 2, 3], [4, 5, 6], [7, 8, 9]], [[1, 1, 1, 2, 2, 4], [1, 0, 0, 1, 1, 2], [2, 2, 0, 2, 0, 100]]))
