//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/07/01.
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

struct Edge {
    var src: Int
    var dest: Int
    var weight: Int
}
let fio = FileIO()
let V = fio.readInt()
let M = fio.readInt()
let INF = 987654321

var edges: [Edge] = []
var dist: [Int] = Array(repeating: INF, count: V + 1)
var isGraphCycle: Bool = false
dist[1] = 0

for _ in 1...M {
    let src = fio.readInt()
    let dest = fio.readInt()
    let weight = fio.readInt()
    edges.append(Edge(src: src, dest: dest, weight: weight))
//    edges[src].append(Edge(dest: dest, weight: weight))
}

for _ in 1...V {
    for edge in edges {
        if dist[edge.src] == INF {
            continue
        } else if dist[edge.dest] > dist[edge.src] + edge.weight {
            dist[edge.dest] = dist[edge.src] + edge.weight
        }
    }
}

for edge in edges {
    if dist[edge.src] == INF {
        continue
    } else if dist[edge.dest] > dist[edge.src] + edge.weight {
        isGraphCycle  = true
        break
    }
}


if isGraphCycle {
    print(-1)
} else {
    for i in 2...V {
        if dist[i] != INF {
            print(dist[i])
        } else {
            print(-1)
        }
    }
}
