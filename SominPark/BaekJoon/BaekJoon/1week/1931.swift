
//  main.swift
//  BaekJoon
//
//  Created by Somin Park on 2022/05/07.
//

import Foundation

let input = Int(readLine()!)!

var inputs: [(Int, Int)] = []
for _ in 0..<input {
    let temp = readLine()!.components(separatedBy: " ").map{Int($0)!}
    inputs.append((temp[0], temp[1]))
}

inputs.sort {
    if $0.1 == $1.1 {
        return $0.0 < $1.0
    }else {
        return $0.1 < $1.1
    }
}

var endTime = 0
var count = 0

for i in inputs {
    if endTime <= i.0 {
        count += 1
        endTime = i.1
    }
}
print(count)
