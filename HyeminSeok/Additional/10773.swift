//
//  main.swift
//  BaekJoon
//
//  Created by Lena on 2022/05/15.
// 10773 제로

import Foundation

let number = Int(readLine()!)!
var stack: [Int] = []
var sum = 0

for _ in 0..<number {
    let input = Int(readLine()!)!
    
    if input == 0 {
        pop()
    } else {
        push(input)
    }
}

for i in stack {
    sum += i
}

print(sum)

func push(_ x: Int) {
    stack.append(x)
}

func pop() {
    stack.popLast()
}
