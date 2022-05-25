//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/05/24.
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

var dist: [Int] = Array(repeating: -1, count: 101)

func findMinDegree(dest: Int) -> Int {
    var child: Int = dest
    var degree: Int = 0
    var result: Int = 1001
    while(parents[child] != child) {
        if(dist[child] >= 0) {
            result = min(dist[child] + degree, result)
        }
        child = parents[child]
        degree += 1
    }
    if(parents[child] == child) {
        result = min(dist[child] + degree, result)
    }
    return result
}

func FindParentAndRegistDist(parents: [Int], child: Int, degree: Int) -> Int {
    if(parents[child] != child) {
        dist[child] = degree
        return FindParentAndRegistDist(parents: parents, child: parents[child], degree: degree + 1)
    }
    dist[child] = degree
    return child
}

func FindParent(parents: [Int], child: Int) -> Int {
    if(parents[child] != child) {
        return FindParent(parents: parents, child: parents[child])
    }
    return child
}
let fio = FileIO()
let N: Int = fio.readInt()
let src: Int = fio.readInt()
let dest: Int = fio.readInt()

let edgeCount : Int = fio.readInt()

var parents: [Int] = Array(repeating: 0, count: N + 1)

for i in 1...N {
    parents[i] = i
}

for _ in 0..<edgeCount {
    let parent: Int = fio.readInt()
    let child: Int = fio.readInt()

    parents[child] = parent
}

if(FindParentAndRegistDist(parents: parents, child: src, degree: 0) == FindParent(parents: parents, child: dest)) {
    print(findMinDegree(dest: dest))
} else {
    print(-1)
}


