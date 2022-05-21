//
//  main.swift
//  BaekJoon
//
//  Created by Lena on 2022/05/09.
//

import Foundation

let n = Int(readLine()!)!
var meeting: [(Int, Int)] = []
var count = 0 // 회의실 개수
var endTime = -1

for _ in 0..<n {
    let input = readLine()!.split(separator: " ").map{Int(String($0))!}
    let start = input[0]
    let end = input[1]
    meeting.append((start, end))
}

meeting.sort {
    $0.1 == $1.1 ? $0.0 < $1.0 : $0.1 < $1.1
}

for i in meeting {
    if endTime <= i.0 {
        count += 1
        endTime = i.1
    }
}

print(count)



