//
//  main.swift
//  BaekJoon
//
//  Created by Somin Park on 2022/05/07.
//

import Foundation

let input = Int(readLine()!)!
var inputs: [[Int]] = []
for _ in 0..<2 {
    let temp = readLine()!.components(separatedBy: " ").map{Int($0)!}
    inputs.append(temp)
}

let A = inputs[0].sorted(by: <)
let B = inputs[1].sorted(by: >)

var answer = 0

for i in 0..<input {
    answer += (A[i] * B[i])
}

print(answer)
