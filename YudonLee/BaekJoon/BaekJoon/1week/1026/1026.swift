//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/05/07.
//

import Foundation

var N: Int = Int(readLine()!)!
var A = readLine()!.components(separatedBy: " ").map({ Int($0)!})
var B = readLine()!.components(separatedBy: " ").map({ Int($0)!})

A.sort()
B.sort()

var sum: Int = 0
for i in 0..<N {
    sum += A[i] * B[N - 1 - i]
}
print(sum)
