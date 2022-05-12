//
//  main.swift
//  BaekJoon
//
//  Created by Somin Park on 2022/05/07.
//

import Foundation

let inputs = readLine()!.components(separatedBy: " ").map{Int($0)!}
var map: [[Int]] = []

for _ in 0..<inputs[0] {
    let temp = readLine()!.components(separatedBy: " ").map{Int($0)!}
    map.append(temp)
}

//N = inputs[0] M = inputs[1] B = inputs[2]

var blocks = 0
var time = 987654321
var heights = 256


while heights >= 0 {
    var inventory = inputs[2]
    var tempTime = 0
    for i in 0..<inputs[0] {
        for j in 0..<inputs[1] {
            if (map[i][j] > heights) {
                tempTime += 2 * (map[i][j] - heights)
                inventory += (map[i][j] - heights)
            }else if (map[i][j] < heights) {
                tempTime += (heights - map[i][j])
                inventory -= (heights - map[i][j])
            }
        }
    }
    if (inventory >= 0 ) {
        if time > tempTime {
            time = tempTime
            blocks = heights
        }
    }
    heights -= 1
}

print("\(time) \(blocks)")
