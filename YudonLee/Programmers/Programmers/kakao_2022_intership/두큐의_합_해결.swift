//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2022/09/19.
//

import Foundation

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
    var leftQueue: Queue<Int64> = Queue<Int64>()
    leftQueue.arr = queue1.map({ Int64($0) })
    leftQueue.rear = queue1.count - 1
    var rightQueue: Queue<Int64> = Queue<Int64>()
    rightQueue.arr = queue2.map({ Int64($0) })
    rightQueue.rear = queue2.count - 1
    
    var leftArr: [Int64] = queue1.map({ Int64($0) })
    var rightArr: [Int64] = queue2.map({ Int64($0) })
    var leftSum: Int64 = Int64(leftArr.reduce(0){$0 + $1})
    var rightSum: Int64 = Int64(rightArr.reduce(0){$0 + $1})
    var cnt = 0
    
    if (leftSum + rightSum) % 2 != 0 {
        return -1
    }
    
    while(leftSum != rightSum && !leftQueue.isEmpty() && !rightQueue.isEmpty()) {
        if cnt > (queue1.count + queue2.count) * 3 {
            return -1
        }
        if leftSum > rightSum {
            let top = leftQueue.top()!
            leftQueue.pop()
            leftSum -= top
            rightQueue.push(element: top)
            rightSum += top
            cnt += 1
        } else {
            let top = rightQueue.top()!
            rightQueue.pop()
            rightSum -= top
            leftQueue.push(element: top)
            leftSum += top
            cnt += 1
        }
    }
    
    return leftSum == rightSum ? cnt : -1
    
}


print(solution([3, 2, 7, 2], [4, 6, 5, 1]))
print(solution([1, 2, 1, 2], [1, 10, 1, 2]))
print(solution([1, 1], [1, 5]))



