//
//  main.swift
//  BaekJoon
//
//  Created by Somin Park on 2022/05/10.
//

import Foundation

let N = Int(readLine()!)!
var NArray = readLine()!.components(separatedBy: " ").map{Int($0)!}
let M = Int(readLine()!)!
var MArray = readLine()!.components(separatedBy: " ").map{Int($0)!}
NArray.sort()
func findElement(_ n: Int, _ arr: [Int]) -> Int {
    var left = 0
    var right = N - 1
    while left <= right {
        let mid = (left + right)/2
        if n > NArray[mid] {
            left = mid + 1
        }else if n < NArray[mid] {
            right = mid - 1
        }else {
            return 1
        }
    }
    return 0
}

for i in MArray {
    print(findElement(i, NArray))
}

