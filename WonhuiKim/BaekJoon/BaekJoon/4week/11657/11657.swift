//
//  11657.swift 타임머신 (Bellman-Ford)
//  BaekJoon
//
//  Created by 김원희 on 2022/07/03.
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

let FIO = FileIO()

let N = FIO.readInt() //도시(정점) 개수
let M = FIO.readInt() //노선(간선) 개수

let maxValue = 10001
//var edges: [[Int]] = Array(repeating: Array(repeating: maxValue, count: N+1), count: N+1)
let maxDist = maxValue*(N-1)
var dist: [Int] = Array(repeating: maxDist, count: N+1)


var edges = [Edge]()

for _ in 0..<M {
    let A = FIO.readInt()
    let B = FIO.readInt()
    let C = FIO.readInt()
    
    edges.append(Edge(src: A, dest: B, weight: C))
}

if bellmanFord(start: 1) {
    print(-1)
} else {
    for i in 1...N {
        if i != 1 {
            if dist[i] == maxDist {
                print(-1)
            } else {
                print(dist[i])
            }
        }
    }
}
//
func bellmanFord(start: Int) -> Bool {

    dist[start] = 0

    for i in 0..<N {
        for j in 0..<M {
            let edge = edges[j]

            if dist[edge.src] != maxDist {
                if dist[edge.dest] > (dist[edge.src] + edge.weight) {
                    dist[edge.dest] = dist[edge.src] + edge.weight

                    if i == N-1 { //N-1번째에도 값이 갱신되면 음수 순환 사이클이므로 true 반환
                        return true
                    }
                }
            }
        }
    }

    return false
}

struct Edge {
    var src: Int
    var dest: Int
    var weight: Int
}
