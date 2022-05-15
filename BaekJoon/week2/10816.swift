//
//  main.swift
//  BaekJoon
//
//  Created by Lena on 2022/05/12.
//

import Foundation
// 첫째줄
let n = Int(readLine()!)!
var nArray = readLine()!.split(separator: " ").map {Int(String($0))!}

// 둘째줄
let m = Int(readLine()!)
let mArray = readLine()!.split(separator: " ").map{Int(String($0))!}

var myDic = [Int:Int]()
var result: [Int] = []

nArray.sort()

for i in nArray {
    if myDic.keys.contains(i) {
        myDic[i]! += 1 // 옵셔널로 반환하므로 언래핑
    } else {
        myDic[i] = 1
    }
}

for j in mArray {
    if myDic.keys.contains(j) {
        result.append(myDic[j]!)
    } else {
        result.append(0)
    }
}

print(result.map{String($0)}.joined(separator: " "))
