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
let testCase = fio.readInt()
let INF = 987654321

for _ in 0..<testCase {
    let V = fio.readInt()
    let M = fio.readInt()
    let W = fio.readInt()
    
    var isGraphCycle: Bool = false
    var edges: [Edge] = []
    
    var startNode: Set<Int> = []
    
    for _ in 1...M {
        let src = fio.readInt()
        let dest = fio.readInt()
        let weight = fio.readInt()
        
        edges.append(Edge(src: src, dest: dest, weight: weight))
        edges.append(Edge(src: dest, dest: src, weight: weight))
    }
    
    for _ in 1...W {
        let src = fio.readInt()
        let dest = fio.readInt()
        let weight = fio.readInt()
        
        edges.append(Edge(src: src, dest: dest, weight: weight * -1))
        startNode.insert(src)
        startNode.insert(dest)
    }
    
    
    for start in startNode {
        if isGraphCycle {
            break
        }
        var dist: [Int] = Array(repeating: INF, count: V + 1)
        dist[start] = 0
        
        for count in 0...V {
            for edge in edges {
                if dist[edge.src] == INF {
                    continue
                } else if dist[edge.dest] > dist[edge.src] + edge.weight {
                    if count == V {
                        isGraphCycle = true
                        break
                    }
                    dist[edge.dest] = dist[edge.src] + edge.weight
                }
            }
        }
    }
    print(isGraphCycle ? "YES" : "NO")
}
