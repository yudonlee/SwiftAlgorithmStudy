//
//  14621.swift 나만 안되는 연애 (MST)
//  BaekJoon
//
//  Created by 김원희 on 2022/07/10.
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


