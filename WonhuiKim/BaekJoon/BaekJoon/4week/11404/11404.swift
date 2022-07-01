//
//  11404.swift (Floyd-Warshall)
//  BaekJoon
//
//  Created by 김원희 on 2022/05/30.
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

let n = FIO.readInt() //도시(정점) 개수
let m = FIO.readInt() //버스(간선) 개수

let maxWeight = 987654321
var weights: [[Int]] = Array(repeating: Array(repeating: maxWeight, count: n+1), count: n+1)

for i in 1...n {
    for j in 1...n {
        if i == j {
            weights[i][j] = 0 //놓친 부분!!
        }
    }
}

for _ in 0..<m {
    let a = FIO.readInt() //시작 src
    let b = FIO.readInt() //도착 dest
    let c = FIO.readInt() //weight

    if weights[a][b] > c {
        weights[a][b] = c
    }
}

floydWarshall(size: n)
printArray(arr: weights, size: n)

func floydWarshall(size: Int) {
    for k in 1...size {
        for i in 1...size {
            for j in 1...size {
                if weights[i][j] > (weights[i][k] + weights[k][j]) {
                    weights[i][j] = weights[i][k] + weights[k][j]
                }
            }
        }
    }
}

func printArray(arr: [[Int]], size: Int) {
    for i in 1...size {
        for j in 1...size {
            if weights[i][j] != maxWeight {
                print(weights[i][j], terminator: " ")
            } else {
                print(0, terminator: " ")
            }
        }
        print()
    }
}
