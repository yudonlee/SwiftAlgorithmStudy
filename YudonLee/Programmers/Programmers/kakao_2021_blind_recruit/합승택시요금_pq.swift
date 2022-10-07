//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2022/09/23.
//

import Foundation

struct PriorityQueue<T> {
    var array: [T] = []
    let compare: (T, T) -> Bool
    
    init(compare: @escaping (T, T) -> Bool) {
        self.compare = compare
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var count: Int {
        return array.count
    }
    
    func leftChildIdx(_ index: Int) -> Int {
        return (2 * index) + 1
    }
    
    func rightChildIdx(_ index: Int) -> Int {
        return (2 * index) + 2
    }
    
    func parentIdx(_ index: Int) -> Int {
        return (index - 1) / 2
    }
    
    mutating func pop() -> T? {
        if array.isEmpty {
            return nil
        }
        
        let value = array.first
        array.swapAt(0, array.count - 1)
        array.popLast()
        shiftDown(0)
        return value
    }
    
    mutating func push(_ element: T) {
        array.append(element)
        shiftUp(array.count - 1)
    }
    
    mutating func shiftDown(_ index: Int) {
        var parent = index
        while true {
            let leftIdx = leftChildIdx(parent)
            let rightIdx = rightChildIdx(parent)
            var candidate = parent
            
//            rightNode 우선 Swap
            if leftIdx < array.count && compare(array[leftIdx], array[candidate]) {
                candidate = leftIdx
            }
            if rightIdx < array.count && compare(array[rightIdx], array[candidate]) {
                candidate = rightIdx
            }
            if candidate == parent {
                return
            }
            array.swapAt(parent, candidate)
            parent = candidate
        }
    }
    
    mutating func shiftUp(_ index: Int) {
        var child = index
        var parent = parentIdx(child)
     
        while true {
            if child <= 0 || !compare(array[child], array[parent]) {
                return
            }
          array.swapAt(child, parent)
          child = parent
          parent = parentIdx(child)
        }
    }
}


struct CommonStart {
    let commonNode: Int
    let arrived: Bool
    let price: Int
}

struct Edge {
    let dest: Int
    let price: Int
}

struct NodeType {
    var pathNode: Bool
    var arrivedNode: Bool
}


func solution(_ n:Int, _ s:Int, _ a:Int, _ b:Int, _ fares:[[Int]]) -> Int {
    var visitedNode: [NodeType] = Array(repeating: NodeType(pathNode: false, arrivedNode: false), count: n + 1)
    var adj: [[Edge]] = Array(repeating: [], count: n + 1)

    fares.forEach { query in
        adj[query[0]].append(Edge(dest: query[1], price: query[2]))
        adj[query[1]].append(Edge(dest: query[0], price: query[2]))
    }

    var pq: PriorityQueue<CommonStart> = PriorityQueue<CommonStart> { leftNode, rightNode in
        leftNode.price < rightNode.price
    }

    func Dijkstra(start: Int, dest: Int) -> Int {
        var pq: PriorityQueue<Edge> = PriorityQueue<Edge> { leftNode, rightNode in
            leftNode.price < rightNode.price
        }

        var visited: [Bool] = Array(repeating: false, count: n + 1)
        pq.push(Edge(dest: start, price: 0))
        while !pq.isEmpty {
            let top = pq.pop()!
            if top.dest == dest {
                return top.price
            }

            if visited[top.dest] {
                continue
            }
            visited[top.dest] = true

            adj[top.dest].forEach { edge in
                if !visited[edge.dest] {
                    pq.push(Edge(dest: edge.dest, price: edge.price + top.price))
                }
            }
        }
        return -1
    }

    pq.push(CommonStart(commonNode: s, arrived: false, price: 0))

    let maxDistance = Dijkstra(start: s, dest: a) + Dijkstra(start: s, dest: b)


    while !pq.isEmpty {
        let top = pq.pop()!

        if visitedNode[top.commonNode].pathNode, !top.arrived {
            continue
        }

        if top.arrived {
            return top.price
        } else {
            visitedNode[top.commonNode].pathNode = true
        }

        adj[top.commonNode].forEach { edge in
            if edge.price + top.price < maxDistance, !visitedNode[edge.dest].pathNode {
                pq.push(CommonStart(commonNode: edge.dest, arrived: false, price: edge.price + top.price))
            }
        }

        let aDist = Dijkstra(start: top.commonNode, dest: a)
        let bDist = Dijkstra(start: top.commonNode, dest: b)
        if aDist != -1, bDist != -1 {
            if aDist + bDist + top.price < maxDistance {
                pq.push(CommonStart(commonNode: top.commonNode, arrived: true, price: aDist + bDist + top.price))
            }
        }

    }
    return maxDistance
}
//import Foundation
//
//struct PriorityQueue<T> {
//    var array: [T] = []
//    let compare: (T, T) -> Bool
//
//    init(compare: @escaping (T, T) -> Bool) {
//        self.compare = compare
//    }
//
//    func isEmpty() -> Bool {
//        return array.isEmpty
//    }
//
//    func count() -> Int {
//        return array.count
//    }
//
//    func leftChildIdx(_ index: Int) -> Int {
//        return (2 * index) + 1
//    }
//
//    func rightChildIdx(_ index: Int) -> Int {
//        return (2 * index) + 2
//    }
//
//    func parentIdx(_ index: Int) -> Int {
//        return (index - 1) / 2
//    }
//
//    mutating func pop() -> T? {
//        if array.isEmpty {
//            return nil
//        }
//
//        let value = array.first
//        array.swapAt(0, array.count - 1)
//        array.popLast()
//        shiftDown(0)
//        return value
//    }
//
//    mutating func push(_ element: T) {
//        array.append(element)
//        shiftUp(array.count - 1)
//    }
//
//    mutating func shiftDown(_ index: Int) {
//        var parent = index
//        while true {
//            let leftIdx = leftChildIdx(parent)
//            let rightIdx = rightChildIdx(parent)
//            var candidate = parent
//
////            rightNode 우선 Swap
//            if leftIdx < array.count && compare(array[leftIdx], array[candidate]) {
//                candidate = leftIdx
//            }
//            if rightIdx < array.count && compare(array[rightIdx], array[candidate]) {
//                candidate = rightIdx
//            }
//            if candidate == parent {
//                return
//            }
//            array.swapAt(parent, candidate)
//            parent = candidate
//        }
//    }
//
//    mutating func shiftUp(_ index: Int) {
//        var child = index
//        var parent = parentIdx(child)
//
//        while true {
//            if child <= 0 || !compare(array[child], array[parent]) {
//                return
//            }
//            array.swapAt(child, parent)
//            child = parent
//            parent = parentIdx(child)
//        }
//    }
//}
//
//struct CommonStart {
//    let commonNode: Int
//    let arrived: Bool
//    let price: Int
//}
//
//struct Edge {
//    let dest: Int
//    let price: Int
//}
//
//struct NodeType {
//    var pathNode: Bool
//    var arrivedNode: Bool
//}
//
//
//func solution(_ n:Int, _ s:Int, _ a:Int, _ b:Int, _ fares:[[Int]]) -> Int {
//    var visitedNode: [NodeType] = Array(repeating: NodeType(pathNode: false, arrivedNode: false), count: n + 1)
//    var adj: [[Edge]] = Array(repeating: [], count: n + 1)
//
//    fares.forEach { query in
//        adj[query[0]].append(Edge(dest: query[1], price: query[2]))
//        adj[query[1]].append(Edge(dest: query[0], price: query[2]))
//    }
//
//    var pq: PriorityQueue<CommonStart> = PriorityQueue<CommonStart> { leftNode, rightNode in
//        leftNode.price < rightNode.price
//    }
//
//    func Dijkstra(start: Int, dest: Int) -> Int {
//        var pq: PriorityQueue<Edge> = PriorityQueue<Edge> { leftNode, rightNode in
//            leftNode.price < rightNode.price
//        }
//
//        var visited: [Bool] = Array(repeating: false, count: n + 1)
//        pq.push(Edge(dest: start, price: 0))
//        while !pq.isEmpty() {
//            let top = pq.pop()!
//            if top.dest == dest {
//                return top.price
//            }
//
//            if visited[top.dest] {
//                continue
//            }
//            visited[top.dest] = true
//
//            adj[top.dest].forEach { edge in
//                if !visited[edge.dest] {
//                    pq.push(Edge(dest: edge.dest, price: edge.price + top.price))
//                }
//            }
//        }
//        return -1
//    }
//
//    pq.push(CommonStart(commonNode: s, arrived: false, price: 0))
//
//    let maxDistance = Dijkstra(start: s, dest: a) + Dijkstra(start: s, dest: b)
//
//
//    while !pq.isEmpty() {
//        let top = pq.pop()!
//
//        if visitedNode[top.commonNode].pathNode, !top.arrived {
//            continue
//        }
//
//        if top.arrived {
//            return top.price
//        } else {
//            visitedNode[top.commonNode].pathNode = true
//        }
//
//        adj[top.commonNode].forEach { edge in
//            if edge.price + top.price < maxDistance, !visitedNode[edge.dest].pathNode {
//                pq.push(CommonStart(commonNode: edge.dest, arrived: false, price: edge.price + top.price))
//            }
//        }
//
//        let aDist = Dijkstra(start: top.commonNode, dest: a)
//        let bDist = Dijkstra(start: top.commonNode, dest: b)
//        if aDist != -1, bDist != -1 {
//            if aDist + bDist + top.price < maxDistance {
//                pq.push(CommonStart(commonNode: top.commonNode, arrived: true, price: aDist + bDist + top.price))
//            }
//        }
//
//    }
//    return maxDistance
//}
//
//
print(solution(6, 4, 6, 2, [[4, 1, 10], [3, 5, 24], [5, 6, 2], [3, 1, 41], [5, 1, 24], [4, 6, 50], [2, 4, 66], [2, 3, 22], [1, 6, 25]]))
print(solution(7, 3, 4, 1, [[5, 7, 9], [4, 6, 4], [3, 6, 1], [3, 2, 3], [2, 1, 6]]))
print(solution(6, 4, 5, 6, [[2, 6, 6], [6, 3, 7], [4, 6, 7], [6, 5, 11], [2, 5, 12], [5, 3, 20], [2, 4, 8], [4, 3, 9]]))
//
//
