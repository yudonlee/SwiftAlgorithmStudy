//
//  file.swift
//  Programmers
//
//  Created by yudonlee on 2022/09/18.
//

import Foundation

struct Point {
    let y: Int
    let x: Int
    
    static func -(left: Point, right: Point) -> Int {
        return abs(left.y - right.y) + abs(left.x - right.x)
    }
}

func checkPartition(_ matrix: [[Character]], _ leftPoint: Point, _ rightPoint: Point) -> Bool {

    if leftPoint.x == rightPoint.x {
        for idx in stride(from: leftPoint.y, to: rightPoint.y, by: rightPoint.y - leftPoint.y > 0 ? 1 : -1) {
            if matrix[idx][rightPoint.x] == "X" {
                return true
            }
        }
        
    }
    
    if leftPoint.y == rightPoint.y {
        for idx in stride(from: leftPoint.x, to: rightPoint.x, by: rightPoint.x - leftPoint.x > 0 ? 1 : -1) {
            if matrix[rightPoint.y][idx] == "X" {
                return true
            }
        }
        
    }
    
    
    if matrix[leftPoint.y][rightPoint.x] == matrix[rightPoint.y][leftPoint.x], matrix[rightPoint.y][leftPoint.x] == "X" {
        return true
    }
    
    return false

    
}

func solution(_ places:[[String]]) -> [Int] {
    var result: [Int] = []
    
    places.forEach { strArray in
        var matrix: [[Character]] = strArray.map { Array($0) }
        var people: [Point] = []
        var manHattan: [(Point, Point)] = []
        
        for i in 0...4 {
            for j in 0...4 {
                if matrix[i][j] == "P" {
                    people.append(Point(y: i, x: j))
                }
            }
        }
        
        for i in 0..<people.count {
            for j in stride(from: i + 1, to: people.count, by: 1) {
                let dist = people[i] - people[j]
                if dist <= 2 {
                    manHattan.append((people[i], people[j]))
                }
            }
        }
        
        var status = false
        manHattan.forEach { leftPoint, rightPoint in
            if !checkPartition(matrix, leftPoint, rightPoint) {
                status = true
                return
            }
        }
        status == true ? result.append(0) : result.append(1)
        
    }
    return result
}


print(solution([["POOOP", "OXXOX", "OPXPX", "OOXOX", "POXXP"], ["POOPX", "OXPXP", "PXXXO", "OXXXO", "OOOPP"], ["PXOPX", "OXOXP", "OXPOX", "OXXOP", "PXPOX"], ["OOOXX", "XOOOX", "OOOXX", "OXOOX", "OOOOO"], ["PXPXP", "XPXPX", "PXPXP", "XPXPX", "PXPXP"]]))
