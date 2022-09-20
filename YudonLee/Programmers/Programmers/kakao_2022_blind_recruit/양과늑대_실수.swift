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
    
    func dfs(_ adj: [Set<Int>], _ visited: inout [Bool], _ sheepIdx: Int, _ dist: Int, _ node: Int) {
        if visited[node] {
            return
        }
        
        visited[node] = true
        
        if info[node] == 0 {
            closest[sheepIdx].append((node, dist))
        }
        adj[node].forEach { nextNode in
            dfs(adj, &visited, info[node] == 0 ? node : sheepIdx, info[node] == 0 ? 0 : dist + 1, nextNode)
        }
        
    }
    
    dfs(adj, &visited, 0, 0, 0)
    
    closest[0].removeFirst()
    var nodes: [(Int, Int)] = [(0,0)]
    var sheep: Int = 0
    var wolf: Int = 0
    
    while(!nodes.isEmpty) {
        var nextNodes: [(Int, Int)] = closest[nodes.first!.0]
        
        if nodes.first!.1 == 0 || sheep > nodes.first!.1 + wolf {
            sheep += 1
            wolf += nodes.first!.1
            nodes.removeFirst()
        } else {
            break
        }
        
        nextNodes.forEach { (node, dist) in
            nodes.append((node, dist))
        }
        
        nodes.sort { leftNode, rightNode in
            leftNode.1 < rightNode.1
        }
    }
    return sheep - 1
}

//print(solution([0, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1], [[0, 1], [1, 2], [1, 4], [0, 8], [8, 7], [9, 10], [9, 11], [4, 3], [6, 5], [4, 6], [8, 9]]))
print(solution([0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0], [[0, 1], [0, 2], [1, 3], [1, 4], [2, 5], [2, 6], [3, 7], [4, 8], [6, 9], [9, 10]]))

