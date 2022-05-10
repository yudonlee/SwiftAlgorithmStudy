//
//  1931.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/05/07.
//

import Foundation

var N: Int
N = Int(readLine()!)!
var meetings: [(Int, Int)] = []

for _ in 0..<N {
    let arr = readLine()!.components(separatedBy: " ").map({ Int($0)!})
//    let arr = readLine()!.split(separator: " ").map({ Int($0)! })
    meetings.append((arr[0], arr[1]))
}

let sorted = meetings.sorted { lhs, rhs in
    return (lhs.1, lhs.0) < (rhs.1, rhs.0)
//    if(lhs.1 <= rhs.1) {
//        if(lhs.0 < rhs.0) return lhs
//    }
//    return rhs
}

var maxCount: Int = 1
var endTime: Int = sorted[0].1
for i in 1..<N {
    
    if(endTime <= sorted[i].0) {
        maxCount += 1
        endTime = sorted[i].1
    }
}
print(maxCount)

