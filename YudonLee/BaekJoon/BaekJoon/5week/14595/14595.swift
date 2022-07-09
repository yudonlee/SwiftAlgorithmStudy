//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/07/03.
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
let N = fio.readInt()
let M = fio.readInt()
var parent = Array(repeating: 0, count: N + 1)

for i in 0...N {
    parent[i] = i
}

func find(node: Int) -> Int {
    if parent[node] != node {
        parent[node] = find(node: parent[node])
        return parent[node]
    }
    return node
}

// union시 rootNode return
func union(left: Int, right: Int) -> Int {
    let lParent = find(node: left)
    let rParent = find(node: right)
    
    if lParent < rParent {
        parent[lParent] = rParent
        return rParent
    }
    
    parent[rParent] = lParent
    return lParent
}

for _ in 0..<M {
    let src = fio.readInt()
    let dest = fio.readInt()
    let r = union(left: src, right: dest)
}

// 전체 rootNode 갱신
var index: Int = 1
var count: Int = 0
while(index <= N) {
    var currentParent = find(node: index)
    while(index < currentParent) {
        currentParent = union(left: currentParent, right: index)
        index += 1
    }
    
    if index == parent[index] {
        count += 1
    }
    index += 1
}
print(count)
