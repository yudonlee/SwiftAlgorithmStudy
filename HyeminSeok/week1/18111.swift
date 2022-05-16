//
//  main.swift
//  BaekJoon
//
//  Created by Lena on 2022/05/09.
//

import Foundation

let threeD = readLine()!.split(separator: " ").map { Int(String($0))!}

let n = threeD[0]
let m = threeD[1]
let block = threeD[2]

var ground = Array(repeating: [Int](), count: n)
var answer = Array(repeating: 0, count: 2)
var maxNum = 0
var minNum = 256


for i in 0..<n {
    ground[i] = readLine()!.split(separator: " ").map { Int(String($0))!}
}

for i in 0..<n {
    for j in 0..<m {
        if ground[i][j] <= minNum {
            minNum = ground[i][j]
        }
        if ground[i][j] >= maxNum {
            maxNum = ground[i][j]
        }
    }
}

for i in stride(from: maxNum, through: minNum, by: -1) {
    var time = 0
    var blockNumber = block
    
    for j in 0..<n {
        for k in 0..<m {
            if ground[j][k] < i {
                blockNumber -= (i - ground[j][k])
                time += (i - ground[j][k])
            } else if ground[j][k] > i {
                blockNumber += ground[j][k] - i
                time += (ground[j][k] - i) * 2
            } else {
                continue
            }
        }
    }
    
    if blockNumber < 0 {
        continue
    }
    
    if answer[0] == 0 {
        answer[0] = time
        answer[1] = i
    } else {
        if answer[0] > time {
            answer[0] = time
            answer[1] = i
        } else if answer[0] == time {
            answer[1] = max(answer[1], i)
        }
    }
}

print(answer[0], answer[1])
