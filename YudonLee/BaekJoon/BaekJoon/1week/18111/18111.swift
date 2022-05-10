//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/05/07.
//
import Foundation

var N, M, B : Int
let inputs = readLine()!.components(separatedBy: " ").map({ Int($0)! })

N = inputs[0]
M = inputs[1]
B = inputs[2]

//var arr = Array(repeating: Array(repeating: 0, count: 5), count: 5)
//var arr = Array(repeating: Array(repeating: 0, count: M), count: N)
var arr: [[Int]] = []
var maxHeight = 256
var maxHeightCase = B


for _ in 0..<N{
    let matrix = readLine()!.components(separatedBy: " ").map({ Int($0)! })
    arr.append(matrix)
    for j in 0..<M {
        maxHeightCase += matrix[j]
    }
}

maxHeight = min(maxHeight, Int(maxHeightCase / (N * M)))

var (minTime, maxFloor) = (1000000000, -1)

for floor in 0...maxHeight {
    var time: Int = 0
    for i in 0..<N {
        for j in 0..<M {
            if(arr[i][j] > floor) {
                time += 2 * (arr[i][j] - floor)
            } else {
                time += floor - arr[i][j]
            }
        }
    }
    if(time <= minTime) {
        (minTime, maxFloor) = (time, floor)
    }
}

print("\(minTime) \(maxFloor)")


