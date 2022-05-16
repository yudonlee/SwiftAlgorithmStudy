//
//  main.swift
//  BackJoon
//
//  Created by Lena on 2022/05/16.
// 2493번 탑 필수응용문제

import Foundation

let input = Int(readLine()!)!
let topArray = readLine()!.split(separator: " ").map{Int(String($0))!} // 탑의 크기를 담는 배열

var stack: [Int] = []
var answer = Array(repeating: 0, count: input) // 발사한 레이저를 담을 배열

for i in stride(from: input-1, to: -1, by: -1) {
    while !stack.isEmpty && topArray[i] > topArray[stack.last!] {
        let idx = stack.removeLast()
        answer[idx] = i + 1
        
    }
    stack.append(i)
}

print(answer.map{String($0)}.joined(separator: " "))
