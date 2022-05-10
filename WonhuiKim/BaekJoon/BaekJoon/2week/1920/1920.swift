//
// 1920.swift
//  BaekJoon
//
//  Created by 김원희 on 2022/05/10.
//

/*
 첫째 줄에 자연수 N(1 ≤ N ≤ 100,000)이 주어진다. 다음 줄에는 N개의 정수 A[1], A[2], …, A[N]이 주어진다. 다음 줄에는 M(1 ≤ M ≤ 100,000)이 주어진다. 다음 줄에는 M개의 수들이 주어지는데, 이 수들이 A안에 존재하는지 알아내면 된다. 모든 정수의 범위는 -231 보다 크거나 같고 231보다 작다
 */

import Foundation

let N = Int(readLine()!)
var arr = readLine()!.split(separator: " ").map{ Int(String($0))! }
arr.sort() //오름차순 정렬 - 이분탐색 위해

let M = Int(readLine()!)!
let values = readLine()!.split(separator: " ").map{ Int(String($0))! }
for i in 0..<M {
    print(binarySearch(arr: arr, target: values[i]))
}


func binarySearch(arr: [Int], target: Int) -> Int {
    var start = 0
    var end = arr.count - 1
    var mid = (start+end)/2
    
    while start <= end {
        if arr[mid] == target {
            return 1;
        } else if arr[mid] > target {
            end = mid - 1
        } else {
            start = mid + 1
        }
        mid = (start+end)/2
    }
    return 0
}

