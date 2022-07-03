//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/06/29.
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
    var weight: CLongLong
    var dest: Int
}

let fio = FileIO()

let N = fio.readInt()
let M = fio.readInt()
var result: CLongLong = -1
var notVisitNode = Array(repeating: true, count: N)
var edges: [[Edge]] = Array(repeating: [], count: N)

var banNode: [Int] = Array(repeating: 0, count: N)
// 0과 1로 이루어져 있는데 혹시 0과 1로 이루어진 bool type으로 가능?
for index in 0..<N {
    let ward = fio.readInt()
    if ward == 1 {
        banNode[index] = 1
    }
}
for _ in 0..<M {
    let src = fio.readInt()
    let dest = fio.readInt()
    let weight = CLongLong(fio.readInt())
    edges[src].append(Edge(weight: weight, dest: dest))
    edges[dest].append(Edge(weight: weight, dest: src))
}


var pq = PriorityQueue<Edge>(sort: { $0.weight < $1.weight })
pq.push((Edge(weight: 0, dest: 0)))


while(!pq.isEmpty) {
    guard let top = pq.pop() else {
        break
    }
    if top.dest == N - 1 {
        result = top.weight
        break
    }

    if banNode[top.dest] == 0, notVisitNode[top.dest] {
        notVisitNode[top.dest] = false
        for edge in edges[top.dest] {
//            여기서 banNode인지 체크하는거 좋긴 한데, 굳이 그럴필요 까진 없다. destination 예외처리가 필요하므로
            if notVisitNode[edge.dest] {
                pq.push(Edge(weight: top.weight + edge.weight, dest: edge.dest))
                
            }
        }
    }
}

print(result)




