//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/07/09.
//

import Foundation

let N = Int(readLine()!)!
var W: Int = 100

var DP: [[Int]] = Array(repeating: Array(repeating: 0, count: W + 1), count: N + 2)


var weights: [Int] = [0] + readLine()!.components(separatedBy: " ").map({ Int($0)! })
var caches: [Int] = [0] + readLine()!.components(separatedBy: " ").map({ Int($0)! })

for k in 1...N {
    
    for wi in 1...W {
        if wi > weights[k] {
            DP[k + 1][wi] = max(DP[k][wi], DP[k][wi - weights[k]] + caches[k])
        } else {
            DP[k + 1][wi] = DP[k][wi]
        }
    }
    
}

print(DP[N + 1][W])

