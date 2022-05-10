//
//  main.swift
//  BaekJoon
//
//  Created by Lena on 2022/05/10.
//

import Foundation

let n = Int(readLine()!)!
var firstArray = readLine()!.split(separator: " ").map{Int(String($0))!}

let m = Int(readLine()!)!
var secondArray = readLine()!.split(separator: " ").map{Int(String($0))!}

firstArray.sort() // 이진탐색 위해 미리 정렬

func binarySearch(_ firstArray: [Int], _ temp: Int) -> Int {
    var start = 0
    var end = firstArray.count - 1
    
    while start <= end {
        let mid = (start + end) / 2
        if firstArray[mid] == temp { // 같은 경우
            return 1
        } else if firstArray[mid] > temp {
            end = mid - 1
        } else if firstArray[mid] < temp {
            start = mid + 1
        }
    }
    return 0
}


for i in 0..<m {
    print(binarySearch(firstArray, secondArray[i]))
}




