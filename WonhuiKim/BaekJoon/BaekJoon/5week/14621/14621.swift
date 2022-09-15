//
//  14621.swift 나만 안되는 연애 (MST)
//  BaekJoon
//
//  Created by 김원희 on 2022/07/10.
//

import Foundation




struct Edge {
    var weight: Int
    var src: Int
    var dest: Int
}

let FIO = FileIO()
let N = FIO.readInt() //학교(정점) 수
let M = FIO.readInt() //도로(간선) 수

var parent = [Int]()
for i in 0...N {
    parent.append(i)
}

var gender: [String] = Array(repeating: "", count: N+1)
for i in 1...N {
    gender[i] = FIO.readString()
}

var pq = PriorityQueue<Edge>(sort: {$0.weight < $1.weight})

for _ in 0..<M {
    let u = FIO.readInt()
    let v = FIO.readInt()
    let d = FIO.readInt()
    
    if gender[u] != gender[v] {
        pq.push(Edge(weight: d, src: u, dest: v))
    }
}

var result = 0
while(!pq.isEmpty) {
    if let now = pq.pop() {
        if FIND(node: now.src) != FIND(node: now.dest) {
            UNION(a: now.src, b: now.dest)
            result += now.weight
        }
    }
}

var isLinked = true
let std = FIND(node: 1)
for i in 2...N {
    if std != FIND(node: i) {
        isLinked = false
        break
    }
}

isLinked == false ? print(-1) : print(result)

func FIND(node: Int) -> Int {
    if node == parent[node] {
        return node
    }
    
    parent[node] = FIND(node: parent[node])
    return parent[node]
}

func UNION(a: Int, b: Int) {
    let root_a = FIND(node: a)
    let root_b = FIND(node: b)
    
    if parent[root_a] > root_b {
        parent[root_a] = root_b
    } else {
        parent[root_b] = root_a
    }
}


