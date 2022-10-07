//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2022/09/20.
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

struct Edge {
    let dest: Int
    let weight: Int
}

let infinite: Int = 10000001


func solution(_ n:Int, _ paths:[[Int]], _ gates:[Int], _ summits:[Int]) -> [Int] {
    var isSummit: [Bool] = Array(repeating: false, count: n + 1)
    var isGate: [Bool] = Array(repeating: false, count: n  + 1)
    
    gates.forEach { gate in
        isGate[gate] = true
    }
    
    summits.forEach { summit in
        isSummit[summit] = true
    }
    
    var adj: [[Edge]] = Array(repeating: [], count: n + 1)
    var result: (summit: Int, minIntensity: Int) = (50001, infinite)
    
    paths.forEach { edge in
        adj[edge[0]].append(Edge(dest: edge[1], weight: edge[2]))
        adj[edge[1]].append(Edge(dest: edge[0], weight: edge[2]))
    }
    
    
    func search(src: Int) -> (Int, Int) {
        var pq: PriorityQueue<Edge> = PriorityQueue<Edge> { leftEdge, rightEdge in
            if leftEdge.weight < rightEdge.weight {
               return true
            } else if leftEdge.weight == rightEdge.weight {
                return leftEdge.dest < rightEdge.dest
            }
            return false
        }
        var visited: [Bool] = Array(repeating: false, count: n + 1)
        var intensity: Int = -1
        var isGate = isGate
        isGate[src] = false
        
        
        pq.push(Edge(dest: src, weight: 0))
        while (!pq.isEmpty) {
            let top = pq.pop()!
            
            if visited[top.dest] {
                continue
            }
            
            visited[top.dest] = true
            
            if intensity < top.weight {
                intensity = top.weight
                if intensity > result.minIntensity {
                    return (-1, -1)
                }
            }
            
            if isSummit[top.dest] {
                return (intensity, top.dest)
            }
            
            adj[top.dest].forEach { edge in
                if !isGate[top.dest] {
                    pq.push(edge)
                }
            }
            
        }
        
        return (-1, -1)
    }
    
    gates.forEach { gate in
        let intensity = search(src: gate)
        if intensity.0 == -1 {
            return
        }
        if result.minIntensity > intensity.0 {
            result.minIntensity = intensity.0
            result.summit = intensity.1
        } else if result.minIntensity == intensity.0 && result.summit > intensity.1 {
            result.summit = intensity.1
        }
    }
    
    return [result.summit, result.minIntensity]
}

print(solution(6, [[1, 2, 3], [2, 3, 5], [2, 4, 2], [2, 5, 4], [3, 4, 4], [4, 5, 3], [4, 6, 1], [5, 6, 1]], [1, 3], [5]))
print(solution(7, [[1, 4, 4], [1, 6, 1], [1, 7, 3], [2, 5, 2], [3, 7, 4], [5, 6, 6]], [1], [2, 3, 4]))
print(solution(7, [[1, 2, 5], [1, 4, 1], [2, 3, 1], [2, 6, 7], [4, 5, 1], [5, 6, 1], [6, 7, 1]], [3, 7], [1, 5]))
print(solution(5, [[1, 3, 10], [1, 4, 20], [2, 3, 4], [2, 4, 6], [3, 5, 20], [4, 5, 6]], [1, 2], [5]))

