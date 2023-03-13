//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2023/03/12.
//

import Foundation

struct Stack<T> {
    var arr: [T] = []

    mutating func push(element: T) {
        arr.append(element)
    }
    func isEmpty()-> Bool {
        return arr.isEmpty
    }

    func top() -> T? {
        if(!isEmpty()) {
            return arr.last
        }
        return nil
    }

    mutating func pop() {
        if(!isEmpty()) {
            arr.removeLast()
        }
    }
}

struct Numbers {
    let currentIdx: Int
    let sum: Int
}

func solution(_ numbers:[Int], _ target:Int) -> Int {
    var answer = 0
    var s = Stack<Numbers>()
    s.push(element: Numbers(currentIdx: 0, sum: 0))
    
    while !s.isEmpty() {
        let top = s.top()!
        s.pop()
        
        if top.currentIdx == numbers.count {
            if top.sum == target {
                answer += 1
            }
        } else {
            s.push(element: Numbers(currentIdx: top.currentIdx + 1, sum: top.sum + numbers[top.currentIdx]))
            s.push(element: Numbers(currentIdx: top.currentIdx + 1, sum: top.sum - numbers[top.currentIdx]))
        }
        
    }
    return answer
}

print(solution([1, 1, 1, 1, 1], 3))
print(solution([4, 1, 2, 1], 4))
