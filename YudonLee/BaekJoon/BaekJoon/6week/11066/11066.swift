//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/07/11.
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
let testCase = fio.readInt()
let INF = 987654321

for _ in 0..<testCase {
    let N = fio.readInt()
//    var sum: [Int] = Array(repeating: 0, count: N + 1)
    var sum: [Int] = [0]
    var DP: [[Int]] = Array(repeating: Array(repeating: 0, count: N + 1), count: N + 1)
    for _ in 0..<N {
        let num = fio.readInt()
        sum.append(num + (sum.last ?? 0))
    }
    
    for i in stride(from: N, through: 1, by: -1) {
        for j in stride(from: i + 1, through: N, by: 1) {
            DP[i][j] = sum[j] - sum[i - 1]
            var minValue = INF
            for k in stride(from: i, to: j, by: 1) {
                minValue = min(minValue, DP[i][k] + DP[k + 1][j])
            }
            if minValue != INF {
                DP[i][j] = minValue + (sum[j] - sum[i - 1])
            }
        }
    }
    print(DP[1][N])
}

