////
////  main.swift
////  Programmers
////
////  Created by yudonlee on 2022/09/15.
////
//
//import Foundation
//
//var cases: [[Int]] = []
//
//func scoreDifference(_ apeach: [Int], _ lion: [Int]) -> Int {
//    var apeachTotal: Int = 0
//    var lionTotal: Int = 0
//    var minCount: (score: Int, count: Int) = (10, 0)
//    for i in 0...10 {
//        if apeach[i] >= lion[i] && apeach[i] > 0 {
//            apeachTotal += (10 - i)
//        } else if lion[i] > 0 && lion[i] > apeach[i] {
//            lionTotal += (10 - i)
//        }
//    }
//
//    return lionTotal - apeachTotal
//}
//
//func priority(origin: [Int], compare: [Int]) -> Bool {
//
//    for i in (0...10).reversed() {
//        if compare[i] > origin[i] {
//            return true
//        } else if origin[i] > compare[i] {
//            return false
//        }
//    }
//    return false
//}
//
//func bfs(_ n: Int, _ branch: [Int], index: Int) {
//    if n == 0 {
//        cases.append(branch)
//        return
//    }
//
//    var extended = branch
//    extended[index] += 1
//
//    if index < 10 {
//        bfs(n, branch, index: index + 1)
//        bfs(n - 1, extended, index: index + 1)
//    }
//    bfs(n - 1, extended, index: index)
//
//}
//
//func solution(_ n:Int, _ info:[Int]) -> [Int] {
//    var max: Int = -9999999
//    var result: [Int] = [-1]
//    let start: [Int] = Array(repeating: 0, count: 11)
//    cases = []
//
//    bfs(n, start, index: 0)
//
//    cases.forEach { unitCase in
//        let diff = scoreDifference(info, unitCase)
//
//        if diff < 0 {
//            return
//        }
//
//        if diff > max {
//            max = diff
//            result = unitCase
//        } else if diff == max {
//            if priority(origin: result, compare: unitCase) {
//            result = unitCase
//            }
//        }
//    }
//    return result
//}
//
//print("solution1",solution(5, [2, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0]))
//print("solution2",solution(1, [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))
//print("solution3",solution(9, [0, 0, 1, 2, 0, 1, 1, 1, 1, 1, 1]))
//print("solution4",solution(10, [0, 0, 0, 0, 0, 0, 0, 0, 3, 4, 3]))
//
//


import Foundation

var cases: [[Int]] = []

func scoreDifference(_ apeach: [Int], _ lion: [Int]) -> (diff: Int, min: (score: Int, count: Int)) {
    var apeachTotal: Int = 0
    var lionTotal: Int = 0
    var minCount: (score: Int, count: Int) = (10, 0)
    for i in 0...10 {
        if apeach[i] >= lion[i] && apeach[i] > 0{
            apeachTotal += (10 - i)
        } else if lion[i] > 0 && lion[i] > apeach[i] {
            lionTotal += (10 - i)
        }

        if lion[i] > 0 {
            minCount = (10 - i, i)
        }
    }

    return (lionTotal - apeachTotal, minCount)
}

func priority(origin: [Int], compare: [Int]) -> Bool {

    for i in (0...10).reversed() {
        if compare[i] > origin[i] {
            return true
        } else if origin[i] > compare[i] {
            return false
        }
    }
    return false
}

func bfs(_ n: Int, _ branch: [Int], index: Int) {
    if n == 0 {
        cases.append(branch)
        return
    }

    var extended = branch
    extended[index] += 1

    if index < 10 {
        bfs(n, branch, index: index + 1)
        bfs(n - 1, extended, index: index + 1)
    }
    bfs(n - 1, extended, index: index)

}

func solution(_ n:Int, _ info:[Int]) -> [Int] {
    var max: Int = -9999999
    var result: [Int] = [-1]
    var minScoreCount: (score: Int, count: Int) = (10, 0)
    let start: [Int] = Array(repeating: 0, count: 11)
    cases = []

    bfs(n, start, index: 0)

    cases.forEach { unitCase in

        let diff = scoreDifference(info, unitCase)

//        비겼을때를 위해 정말 필요함!
        if diff.diff <= 0 {
            return
        }

        if diff.diff > max {
            max = diff.diff
            result = unitCase
            minScoreCount = diff.min
        } else if diff.diff == max && ( diff.min.score < minScoreCount.score || (diff.min.score ==  minScoreCount.score && diff.min.count >= minScoreCount.count)) {
            if diff.min.count == minScoreCount.count && !priority(origin: result, compare: unitCase){
                return
            }
            result = unitCase
            minScoreCount = diff.min
        }
    }
    return result
}

print("solution1",solution(5, [2, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0]))
print("solution2",solution(1, [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))
print("solution3",solution(9, [0, 0, 1, 2, 0, 1, 1, 1, 1, 1, 1]))
print("solution4",solution(10, [0, 0, 0, 0, 0, 0, 0, 0, 3, 4, 3]))
print("solution",solution(1, [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0]))
print("solution",solution(1, [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))
print(solution(3, [0,0,1,0,0,0,0,0,0,1,0]))
