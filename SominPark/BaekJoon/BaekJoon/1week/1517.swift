//
//  main.swift
//  BaekJoon
//
//  Created by Somin Park on 2022/05/07.
//

import Foundation


let input = Int(readLine()!)!
var inputs = [Int]()

inputs = readLine()!.components(separatedBy: " ").map{Int($0)!}


var count = 0
var flag = true

while flag {
    flag = false
    for i in 0..<(input - 1) {
        if (inputs[i] > inputs[i + 1]) {
            count += 1
            let temp = inputs[i]
            inputs[i] = inputs[i + 1]
            inputs[i + 1] = temp
            flag = true
        }
    }
}
print(count)

