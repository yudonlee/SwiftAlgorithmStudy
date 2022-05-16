//
//  main.swift
//  BackJoon
//
//  Created by Lena on 2022/05/16.
//

// 1874번 스택수열 (응용문제)

import Foundation

let n = Int(readLine()!)!

var number = 1  // 맞는 수인지 확인하는 용도
var stack: [Int] = []
var output: [String]  = [] // push 면 +, pop이면 -, 불가능하면 NO / stack 연산들을 담아놓을 배열

for _ in 0..<n {
    let num = Int(readLine()!)!
    
    while number <= num { // 입력한 수보다 작으면 push 해야하니까
        stack.append(number)
        output.append("+")
        number += 1
    }
    
    if stack.last == num {
        stack.popLast() // 원하는 값을 찾으면 pop
        output.append("-")
    } else {
        print("NO")
        exit(0)
    }
}

print(output.joined(separator: "\n"))
