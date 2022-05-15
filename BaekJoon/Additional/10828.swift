//
//  main.swift
//  BaekJoon
//
//  Created by Lena on 2022/05/15.
// 10828번

import Foundation

var number = Int(readLine()!)!
var stack: [Int] = []

func push(_ number: Int) {
    stack.append(number)
}

func pop() -> Int {
    if stack.isEmpty {
        return -1
    } else {
        let popValue = stack.popLast()
        return popValue!
    }
}

func size() -> Int {
    return stack.count
}

func isEmpty() -> Int {
    if stack.isEmpty {
        return 1
    } else {
        return 0
    }
}

func top() -> Int {
    if stack.isEmpty {
        return -1
    } else {
        return stack[stack.count-1]
    }
}

for _ in 0..<number {
    let input = readLine()!.split(separator: " ").map{String($0)}
    
    switch input[0] {
    case "push":
        push(Int(input[1])!)
    case "pop":
        print(pop())
        break
    case "size":
        print(size())
        break
    case "empty":
        print(isEmpty())
        break
    case "top":
        print(top())
    default:
        break
    }
}
