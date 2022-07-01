//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/06/30.
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
let INF = 987654321
var dist: [[Int]] = Array(repeating: Array(repeating: INF, count: N + 1), count: N + 1)

for i in 1...N {
    dist[i][i] = 0
}

for _ in 0..<M {
    let src = fio.readInt()
    let dest = fio.readInt()
    dist[src][dest] = 1
    dist[dest][src] = 1
}


for k in 1...N {
    for i in 1...N {
        for j in 1...N {
            dist[i][j] = min(dist[i][k] + dist[k][j], dist[i][j])
        }
    }
}


var parent: [Int] = Array(repeating: 0, count: N + 1)
var groupMember: [[Int]] = []

for i in 1...N {
    if parent[i] == 0 {
        var group: [Int] = []
        for j in 1...N {
            if dist[i][j] != INF, parent[j] == 0{
                parent[j] = i
                group.append(j)
            }
        }
        groupMember.append(group)
    }
}


var result: [Int] = []
for group in groupMember {
    var maxWeight = INF
    var president = -1
    for i in group {
        var weight = 0
        for j in group {
            if dist[i][j] > weight {
                weight = dist[i][j]
            }
        }
        if weight < maxWeight {
            maxWeight = weight
            president = i
        }
    }
    result.append(president)
}
result.sort()


print(groupMember.map({ $0 }).count)
for item in result {
    print(item)
}

