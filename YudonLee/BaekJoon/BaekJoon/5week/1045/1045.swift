//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/07/08.
//

import Foundation

final class FileIO {
    private let buffer:[UInt8]
    private var index: Int = 0

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        
        buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }

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
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
    }

    @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return Array(buffer[beginIndex..<(index-1)])
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

struct Edge {
    var src: Int
    var dest: Int
}

let fio = FileIO()
let N = fio.readInt()
let M = fio.readInt()

var parents: [Int] = []
var edges: [Edge] = []
var connected: [Int] = Array(repeating: 0, count: N)

for i in 0..<N {
    parents.append(i)
}
func find(node: Int) -> Int {
    if parents[node] != node {
        parents[node] = find(node: parents[node])
        return parents[node]
    }
    return node
}

func union(left: Int, right: Int) {
    let lParent = find(node: left)
    let rParent = find(node: right)
    
    if lParent < rParent {
        parents[rParent] = lParent
    } else {
        parents[lParent] = rParent
    }
}
for i in 0..<N {
    let edge = fio.readString()
    for j in 0..<N {
        let value = edge.index(edge.startIndex, offsetBy: j)
        if edge[value] == "Y", i < j {
            edges.append(Edge(src: i, dest: j))
        }
    }
}

var count: Int = 1
var leftEdges: [Edge] = []
if edges.count < M {
    print(-1)
} else {
    // 최대한 서로 다른것들만 우선적으로 채운다.
    for edge in edges {
        if find(node: edge.src) != find(node: edge.dest) {
            union(left: edge.src, right: edge.dest)
            connected[edge.src] += 1
            connected[edge.dest] += 1
            count += 1
        } else {
            leftEdges.append(edge)
        }
    }
    
    
    if count == N {
        for index in 0..<M - (N - 1) {
            let top = leftEdges[index]
            connected[top.src] += 1
            connected[top.dest] += 1
        }
        
        for item in connected {
            print(item, terminator: " ")
        }
    } else {
        print(-1)
    }
}

