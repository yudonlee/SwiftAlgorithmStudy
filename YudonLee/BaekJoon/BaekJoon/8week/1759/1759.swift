//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/07/12.
//

import Foundation

let input = readLine()!.components(separatedBy: " ").map({ Int($0)! })
let N = input[0]
let M = input[1]

func backTracking(arr: [Int], visit: [Bool], current: Int) {
    var copiedVisit = visit
    copiedVisit[current] = true
    var added = arr + [current]
    
    if added.count == M {
        for item in added {
            print(item, terminator: " ")
        }
        print()
        return
    }
    else if added.count < M {
        for iter in 1...N {
            if !copiedVisit[iter] {
                backTracking(arr: added, visit: copiedVisit, current: iter)
            }
        }
    }
}

for start in 1...N {
    backTracking(arr: [], visit: Array(repeating: false, count: N + 1), current: start)
}
