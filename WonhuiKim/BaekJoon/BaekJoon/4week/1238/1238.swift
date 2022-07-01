//
//  1238.swift 파티(Dijkstra)
//  BaekJoon
//
//  Created by 김원희 on 2022/06/30.
//

import Foundation

final class FileIO {
    private let buffer: Data
    private var index: Int = 0
    
    init(fileHandle: FileHandle = FileHandle.standardInput) {
        self.buffer = try! fileHandle.readToEnd()! // 인덱스 범위 넘어가는 것 방지
    }
    
    @inline(__always) private func read() -> UInt8 {
        defer {
            index += 1
        }
        guard index < buffer.count else { return 0 }
        
        return buffer[index]
    }
    
    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true
        
        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }
        
        return sum * (isPositive ? 1:-1)
    }
    
    
    @inline(__always) func readString() -> String {
        var str = ""
        var now = read()
        
        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        
        while now != 10
                && now != 32 && now != 0 {
            str += String(bytes: [now], encoding: .ascii)!
            now = read()
        }
        
        return str
    }
}

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

let FIO = FileIO()

let N = FIO.readInt() //학생(정점) 수
let M = FIO.readInt() //도로(간선) 수
let X = FIO.readInt() //시작점

struct Edge {
    var weight: Int
    var dest: Int
}

var edges: [[Edge]] = Array(repeating: [], count: N+1)
var edgesReverse: [[Edge]] = Array(repeating: [], count: N+1)

for _ in 0..<M {
    let src = FIO.readInt()
    let dest = FIO.readInt()
    let weight = FIO.readInt()
    
    edges[src].append(Edge(weight: weight, dest: dest))
    edgesReverse[dest].append(Edge(weight: weight, dest: src))
}

let maxDist = 987654321
var dist: [Int] = Array(repeating: maxDist, count: N+1)
var distReverse: [Int] = Array(repeating: maxDist, count: N+1)
var pq = PriorityQueue<(Int, Int)>(sort: {$0.0 < $1.0})

pq.push((0, X))

while(!pq.isEmpty) {
    if let now = pq.pop() {
        if dist[now.1] == maxDist {
            dist[now.1] = now.0
            for next in edges[now.1] {
                if dist[next.dest] == maxDist {
                    pq.push((now.0 + next.weight, next.dest))
                }
            }
        }
    }
}

pq.push((0, X))

while(!pq.isEmpty) {
    if let now = pq.pop() {
        if distReverse[now.1] == maxDist {
            distReverse[now.1] = now.0
            for next in edgesReverse[now.1] {
                if distReverse[next.dest] == maxDist {
                    pq.push((now.0 + next.weight, next.dest))
                }
            }
        }
    }
}


dist[1] = dist[1] + distReverse[1]
var max = dist[1]
for i in 2...N {
    dist[i] += distReverse[i]
    if max < dist[i] {
        max = dist[i]
    }
}

print(max)
