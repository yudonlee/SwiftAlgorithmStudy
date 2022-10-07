//
//  File.swift
//  Programmers
//
//  Created by yudonlee on 2022/09/24.
//

import Foundation

struct PriorityQueue<T> {
  var array = [T]()
  let sort: (T, T) -> Bool

  init(sort: @escaping (T, T) -> Bool) {
    self.sort = sort
  }

  var isEmpty: Bool {
    return array.isEmpty
  }

  var count: Int {
    return array.count
  }

  func peek() -> T? {
    return array.first
  }

  func leftChildIndex(ofParentAt index: Int) -> Int {
    return (2 * index) + 1
  }

  func rightChildIndex(ofParentAt index: Int) -> Int {
    return (2 * index) + 2
  }

  func parentIndex(ofChildAt index: Int) -> Int {
    return (index - 1) / 2
  }

  // MARK:- remove operation
  mutating func pop() -> T? {
    guard !isEmpty else {
      return nil
    }

    array.swapAt(0, count - 1)
    defer {
      siftDown(from: 0)
    }
    return array.removeLast()
  }

  mutating func siftDown(from index: Int) {
    var parent = index
    while true {
      let left = leftChildIndex(ofParentAt: parent)
      let right = rightChildIndex(ofParentAt: parent)
      var candidate = parent

      if left < count && sort(array[left], array[candidate]) {
        candidate = left
      }
      if right < count && sort(array[right], array[candidate]) {
        candidate = right
      }
      if candidate == parent {
        return
      }
      array.swapAt(parent, candidate)
      parent = candidate
    }
  }

  // MARK:- insert operation
  mutating func push(_ element: T) {
    array.append(element)
    siftUp(from: array.count - 1)
  }

  mutating func siftUp(from index: Int) {
    var child = index
    var parent = parentIndex(ofChildAt: child)
    while child > 0 && sort(array[child], array[parent]) {
      array.swapAt(child, parent)
      child = parent
      parent = parentIndex(ofChildAt: child)
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
