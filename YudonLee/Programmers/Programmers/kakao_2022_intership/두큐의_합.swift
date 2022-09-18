//
//  File.swift
//  Programmers
//
//  Created by yudonlee on 2022/09/15.
//

import Foundation



//func solution(_ queue1:[Int], _ queue2:[Int]) -> Int {
//    let sum = queue1.reduce(0){$0 + $1} + queue2.reduce(0){$0 + $1}
//    if sum % 2 != 0 {
//        return -1
//    }
//
//    var divide = queue1.count
//
//    let totalArray = queue1 + queue2
//
//    var rangeList: [(start: Int, end: Int)] = []
//
//    for startIdx in 0..<(totalArray.count - 1) {
//        var half: Int = sum / 2
//
//        for lastIdx in stride(from: startIdx, to: totalArray.count - 1, by: 1) {
//            half -= totalArray[lastIdx]
//            if half == 0 {
//                rangeList.append((startIdx, lastIdx))
//            } else if half < 0 {
//                break
//            }
//        }
//    }
//
//    return -2
//}

func solution(_ queue1:[Int], _ queue2:[Int]) -> Int {
    
    var leftQueue: [Int64] = queue1.map({ Int64($0) })
    var rightQueue: [Int64] = queue2.map({ Int64($0) })
    
    var leftSum: Int64 = Int64(leftQueue.reduce(0){$0 + $1})
    var rightSum: Int64 = Int64(rightQueue.reduce(0){$0 + $1})
    
    if (leftSum + rightSum) % 2 != 0 {
        return -1
    }
    var cnt = 0
    
    
    
    while(leftSum != rightSum && !leftQueue.isEmpty && !rightQueue.isEmpty) {
        if leftSum > rightSum {
            let x = Int64((leftQueue.first)!)
            rightQueue.append(x)
            rightSum += x
            leftSum -= x
            leftQueue.removeFirst()
            cnt += 1
        } else if leftSum < rightSum {
            let x = Int64((rightQueue.first)!)
            leftQueue.append(x)
            leftSum += x
            rightSum -= x
            rightQueue.removeFirst()
            cnt += 1
        }
        
        if cnt > (queue1.count + queue2.count) * 2 {
            return -1
        }
    }
    
    
    return cnt > 0 ? cnt : -1
    
}





//print(solution([3, 2, 7, 2], [4, 6, 5, 1]))
//print(solution([1, 2, 1, 2],[1, 10, 1, 2]))
print(solution([ 1, 1, 1, 1, 1, 1, 1, 1, 1, 10], [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
                                                 ]))
