//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2022/09/24.
//

import Foundation

// arr에 대입시 rear 주의!
struct Queue<T> {
    var arr:[T] = []
    var front: Int = 0
    var rear: Int = -1
    
    func isEmpty() -> Bool {
        if(front <= rear) {
            return false
        }
        return true
    }
    mutating func push(element: T) {
        arr.append(element)
        rear += 1
    }
    func top() -> T? {
        if(!isEmpty()) {
            return arr[front]
        }
        return nil
    }
    mutating func pop() {
        if(!isEmpty()) {
            front += 1
        }
    }
}

func solution(_ queue1:[Int], _ queue2:[Int]) -> Int {
    var leftQueue: Queue<Int> = Queue<Int>()
    leftQueue.arr = queue1
    leftQueue.rear = queue1.count - 1
    var rightQueue: Queue<Int> = Queue<Int>()
    rightQueue.arr = queue2
    rightQueue.rear = queue2.count - 1
    
    var leftSum: Int64 = queue1.reduce(into: 0) { partialResult, value in
        partialResult += Int64(value)
    }
    
    var rightSum: Int64 = queue2.reduce(into: 0) { partialResult, value in
        partialResult += Int64(value)
    }
    
    var count = 0
    
    while(leftSum != rightSum ) {
        if count > (queue1.count + queue2.count) * 3 || leftQueue.isEmpty() || rightQueue.isEmpty() {
            return -1
        }
        count += 1
        if leftSum < rightSum {
            let moved = Int64(rightQueue.top()!)
            rightQueue.pop()
            rightSum -= moved
            leftSum += moved
            leftQueue.push(element: Int(moved))
        } else {
            let moved = Int64(leftQueue.top()!)
            leftQueue.pop()
            leftSum -= moved
            rightSum += moved
            rightQueue.push(element: Int(moved))
        }
    }
    
    return count
}


print(solution([3, 2, 7, 2], [4, 6, 5, 1]))
print(solution([1, 2, 1, 2], [1, 10, 1, 2]))
print(solution([1, 1], [1, 5]))
