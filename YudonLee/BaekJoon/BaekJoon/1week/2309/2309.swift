//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/05/07.
//

import Foundation

var array: [Int] = []
var sum: Int = 0

for _ in 0..<9 {
    var input: Int = Int(readLine()!)!
    sum += input
    array.append(input)
}

array.sort()
var status: Bool = false
for first in 0...8 {
    if(status) {
        break
    }
    for second in 0...8 {
        if(first == second) {
            continue
        }
        
        if(sum - array[first] - array[second] == 100) {
            for answer in 0...8 {
                if(answer != first && answer != second) {
                    print(array[answer])
                    status = true
                }
            }
        }
    }
}


