//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2022/09/22.
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
    let alp: Int
    let cop: Int
    let time: Int
}


import Foundation

func solution(_ alp:Int, _ cop:Int, _ problems:[[Int]]) -> Int {
    
    var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: 151), count: 151)
    var newProblems: [[Int]] = problems + [[0, 0, 1, 0, 1], [0, 0, 0, 1, 1]]
    var maxRequiredAlp: Int = 0
    var maxRequiredCop: Int = 0
    
    newProblems.forEach { data in
        maxRequiredAlp = data[0] > maxRequiredAlp ? data[0] : maxRequiredAlp
        maxRequiredCop = data[1] > maxRequiredCop ? data[1] : maxRequiredCop
    }
    
    
    var pq: PriorityQueue<Edge> = PriorityQueue<Edge> { leftEdge, rightEdge in
        leftEdge.time < rightEdge.time
    }
    
    pq.push(Edge(alp: alp, cop: cop, time: 0))
    
    
    while(!pq.isEmpty) {
        let top = pq.pop()!
        if visited[top.alp][top.cop] {
            continue
        }
        visited[top.alp][top.cop] = true
        if top.alp >= maxRequiredAlp && top.cop >= maxRequiredCop {
            return top.time
        }
        
        newProblems.forEach { data in
            if top.alp >= data[0] && top.cop >= data[1] {
                pq.push(Edge(alp: top.alp + data[2] , cop: top.cop + data[3], time: top.time + data[4]))
            }
        }
        
    }
    return 0
}

print(solution(10, 10, [[10, 15, 2, 1, 2], [20, 20, 3, 3, 4]]))
print(solution(0, 0, [[0, 0, 2, 1, 2], [4, 5, 3, 1, 2], [4, 11, 4, 0, 2], [10, 4, 0, 4, 2]]))


