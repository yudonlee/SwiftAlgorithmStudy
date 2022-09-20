//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2022/09/19.
//

import Foundation


func solution(_ info:[Int], _ edges:[[Int]]) -> Int {
    var adj: [Set<Int>] = Array(repeating: [], count: info.count)
    var visited: [Bool] = Array(repeating: false, count: info.count)
    var closest: [[(nodeIdx: Int, dist: Int)]] = Array(repeating: [], count: info.count)
    
    var result: Int = 0
    
    edges.forEach {
        adj[$0[0]].update(with: $0[1])
        adj[$0[1]].update(with: $0[0])
    }
    
    func dfs(_ idx: Int, sheepCount: Int, wolfCount: Int, nodeToVisit: [Int], visited: [Bool]) {
        var sheepCount = sheepCount
        var wolfCount = wolfCount
        var nodeToVisit = nodeToVisit
        var visited = visited
        sheepCount += info[idx] ^ 1
        wolfCount += info[idx]
        visited[idx] = true
        
        if sheepCount <= wolfCount && wolfCount > 0 {
            return
        } else {
            result = sheepCount > result ? sheepCount : result
            nodeToVisit = nodeToVisit + adj[idx]
        }
        
        for i in 0..<nodeToVisit.count {
            var newVisit = nodeToVisit
            newVisit.remove(at: i)
            if !visited[nodeToVisit[i]] {
                dfs(nodeToVisit[i], sheepCount: sheepCount, wolfCount: wolfCount, nodeToVisit: newVisit, visited: visited)
            }
        }
    }
    
    dfs(0, sheepCount: 0, wolfCount: 0, nodeToVisit: [], visited: Array(repeating: false, count: info.count))
    
    return result
}

print(solution([0, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1], [[0, 1], [1, 2], [1, 4], [0, 8], [8, 7], [9, 10], [9, 11], [4, 3], [6, 5], [4, 6], [8, 9]]))
print(solution([0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0], [[0, 1], [0, 2], [1, 3], [1, 4], [2, 5], [2, 6], [3, 7], [4, 8], [6, 9], [9, 10]]))
