//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/07/06.
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
    var weight: Int
}
let fio = FileIO()
let N = fio.readInt()
let M = fio.readInt()
var parents: [Int] = []

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
for i in 0...N {
    parents.append(i)
}

var pq = PriorityQueue<Edge>(sort: { $0.weight < $1.weight})
var result: Int64 = 0

for _ in 0..<M {
    let src = fio.readInt()
    let dest = fio.readInt()
    let weight = fio.readInt()
    pq.push(Edge(src: src, dest: dest, weight: weight))
}

var count = 1

while(!pq.isEmpty) {
    guard let t = pq.pop() else {
        fatalError()
    }
    if find(node: t.src) != find(node: t.dest) {
        union(left: t.src, right: t.dest)
        count += 1
        if count == N {
            break
        }
        result += Int64(t.weight)
    }
}

print(result)

