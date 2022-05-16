//
//  main.swift
//  BaekJoon
//
//  Created by Lena on 2022/05/14.
//

// 3020번 개똥벌레

import Foundation

let input = readLine()!.split(separator: " ").map { Int(String($0))!}
var n = input[0] // 동굴의 길이 n
var h = input[1] // 동굴의 높이 H
var lower: [Int] = [] // 석순
var upper: [Int] = [] // 종류석

for i in 0..<n {
    if i % 2 == 0 {
        lower.append(Int(readLine()!)!) // 짝수인것만 담기
    } else {
        upper.append(Int(readLine()!)!)
    }
}

lower.sort()
upper.sort()

// 이진탐색
func binarySearch(_ array: [Int], target: Int, isUpper: Bool) -> Int {
    var min = 0
    var max = array.count
    
    while min < max {
        let mid = (min + max) / 2
        if target == array[mid] {
            isUpper ? (min = mid + 1) : (max = mid)
        } else if target < array[mid] {
            max = mid
        } else {
            min = mid + 1
        }
    }
    return min
}

var minDic = [Int:Int]()
var minKey: Int = 9999999  

for height in 1...h { // 높이를 하나씩 넣으면서 이진탐색
    var count = lower.count - binarySearch(lower, target: height, isUpper: false)
    count += upper.count - binarySearch(upper, target: h - height, isUpper: true)
    
    if minDic.keys.contains(count) {
        minDic[count]! += 1
    } else {
        minDic[count] = 1
        if count < minKey {
            minKey = count
        }
    }
}

print(minKey, minDic[minKey]!) // 언래핑 해줘야지
