//
//  main.swift
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

let dy: [Int] = [1, 0, -1, 0]
let dx: [Int] = [0, 1, 0, -1]

var bfsFinished = false
var bfsResult: Int = 0

func bfs(_ visited: [[Bool]], _ matrix: [[Character]], _ currentPoint: Point, _ destPoint: Point) {
    
    if bfsFinished {
        return
    }
    
    if visited[currentPoint.y][currentPoint.x] || matrix[currentPoint.y][currentPoint.x] == "X" || (matrix[currentPoint.y][currentPoint.x] == "P" && currentPoint.y != destPoint.y && currentPoint.x != destPoint.x) {
        return
    }
    
    var visit = visited
    visit[currentPoint.y][currentPoint.x] = true
    
    if !bfsFinished && currentPoint.y == destPoint.y && currentPoint.x == destPoint.x {
        bfsResult -= 1
        bfsFinished = true
        return
    }
    
    for idx in 0..<4 {
        let nextY = dy[idx] + currentPoint.y
        let nextX = dx[idx] + currentPoint.x
        if 0 <= nextY, nextY < 5, 0 <= nextX, nextX < 5, !visit[nextY][nextX] {
            bfs(visit, matrix, Point(y: nextY, x: nextX), destPoint)
        }
    }
    
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
        
        bfsFinished = false
        bfsResult = 1
        
        manHattan.forEach { leftPoint, rightPoint in
            var visit: [[Bool]] = Array(repeating: Array(repeating: false, count: 5), count: 5)
            bfs(visit, matrix, leftPoint, rightPoint)
        }
        result.append(bfsResult)
        
    }
    return result
}

print(solution([["POOOP", "OXXOX", "OPXPX", "OOXOX", "POXXP"], ["POOPX", "OXPXP", "PXXXO", "OXXXO", "OOOPP"], ["PXOPX", "OXOXP", "OXPOX", "OXXOP", "PXPOX"], ["OOOXX", "XOOOX", "OOOXX", "OXOOX", "OOOOO"], ["PXPXP", "XPXPX", "PXPXP", "XPXPX", "PXPXP"]]))
