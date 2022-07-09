//
//  1976.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/07/04.
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

let fio = FileIO()
// 도시수
let N = fio.readInt()
// 여행계획수
let M = fio.readInt()

var parents = Array(repeating: 0, count: N + 1)

for i in 1...N {
    parents[i] = i
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
    
    if lParent > rParent {
        parents[lParent] = rParent
    } else {
        parents[rParent] = lParent
    }
}


for i in 1...N {
    for j in 1...N {
        let check = fio.readInt()
        if check == 1 {
            union(left: i, right: j)
        }
    }
}

var rootNode: Int = 0
var status: Bool = true
for i in 1...M {
    let node = fio.readInt()
    if i != 1 {
        if find(node: node) != rootNode {
            status = false
            break
        }
    } else {
        rootNode = find(node: node)
    }
}
print(status ? "YES" : "NO")
