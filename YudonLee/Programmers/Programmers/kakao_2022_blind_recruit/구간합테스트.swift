//
//  구간합.swift
//  Programmers
//
//  Created by yudonlee on 2022/09/18.
//

import Foundation


func solution(_ board:[[Int]], _ skill:[[Int]]) -> Int {
    var psum = Array(repeating: board[0][0], count: board[0].count)
    for idx in 1..<board[0].count {
        psum[idx] = psum[idx - 1] + board[0][idx]
    }
    print(psum)
    return 0
}

print(solution([[5, 5, 5, 5, 5], [5, 5, 5, 5, 5], [5, 5, 5, 5, 5], [5, 5, 5, 5, 5]], [[1, 0, 0, 3, 4, 4], [1, 2, 0, 2, 3, 2], [2, 1, 0, 3, 1, 2], [1, 0, 1, 3, 3, 1]]))
print(solution([[1, 2, 3], [4, 5, 6], [7, 8, 9]], [[1, 1, 1, 2, 2, 4], [1, 0, 0, 1, 1, 2], [2, 2, 0, 2, 0, 100]]))
