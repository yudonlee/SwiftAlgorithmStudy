//
//  main.swift
//  BaekJoon
//
//  Created by Somin Park on 2022/05/10.
//

import Foundation

let N = Int(readLine()!)!
var NArray = readLine()!.split(separator: " ").map{Int($0)!}.sorted()
let M = Int(readLine()!)!
var MArray = readLine()!.split(separator: " ").map{Int($0)!}
var answer = ""
var dict: [Int:Int] = [:]

for i in NArray {
    if dict.keys.contains(i) {
        dict[i]! += 1
    }else {
        dict[i] = 1
    }
}

for i in MArray {
    if dict.keys.contains(i) {
        answer += "\(dict[i]!) "
    }else {
        answer += "0 "
    }
}
print(answer)

//func findElement(_ n: Int, _ arr: [Int]) -> Int {
//    var left = 0
//    var right = arr.count - 1
//    while left <= right {
//        let mid = (left + right)/2
//        if n > arr[mid] {
//            left = mid + 1
//        }else if n < arr[mid] {
//            right = mid - 1
//        }else {
//            return mid
//        }
//    }
//    return -1
//
//}
//
//var ret = ""
//for i in 0..<(MArray.count) {
//    var count = 0
//    var result = findElement(MArray[i], NArray)
//    while result >= 0 {
//        NArray.remove(at: result)
//        count += 1
//        result = findElement(MArray[i], NArray)
//    }
//    ret += "\(count) "
//}
//print(ret)
