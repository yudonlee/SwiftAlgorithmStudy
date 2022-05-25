//
//  main.swift
//  BackJoon
//
//  Created by Lena on 2022/05/16.
// 1654번 랜선자르기

import Foundation

let input = readLine()!.split(separator:" ").map{Int(String($0))!}

let k = input[0] // 가지고 있는 랜선의 개수
let n = input[1] // 필요한 랜선의 개수

var lanLines: [Int] = [] // 가지고 있는 랜선의 길이들을 담을 배열
for _ in 0..<k {
    lanLines.append(Int(readLine()!)!)
}

var low = 1
var high = lanLines.max()! // 최댓값

var result = 0

// 이진탐색
while (low <= high) {
    let mid = (low + high) / 2
    var sum = 0 // 랜선의 개수 합 
    
    for i in lanLines {
        if i < mid {
            continue
        }
        sum += i / mid
    }
    
    if sum >= n { // 가지고 있는 랜선 길이가 sum보다 작은 경우, 랜선 길이를 늘린다
        if result < mid {
            result = mid
        }
        low = mid + 1
    }
    else { // 큰 경우, 랜선 길이 줄인다
        high = mid - 1
    }
}

print(result)
