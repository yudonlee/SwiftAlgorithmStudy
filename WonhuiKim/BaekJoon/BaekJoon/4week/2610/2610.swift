//
//  2610.swift (회의 준비, Floyd-Warshall)
//  BaekJoon
//
//  Created by 김원희 on 2022/07/01.
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
let N = FIO.readInt() //회의 참석자(정점) 수
let M = FIO.readInt() //관계(간선) 수

let maxWeight = 987654321
var arr: [[Int]] = Array(repeating: Array(repeating: maxWeight, count: N+1), count: N+1)

for i in 1...N {
    for j in 1...N {
        if i==j {
            arr[i][j] = 0
        }
    }
}
for _ in 0..<M {
    let a = FIO.readInt()
    let b = FIO.readInt()
    
    arr[a][b] = 1
    arr[b][a] = 1
}

floydWarshall(size: N)

var maxDist: [Int] = Array(repeating: 0, count: N+1)
calMaxDist(size: N)

var cnt = 0
var reps = [Int]()
findRep(size: N)
print(cnt)

reps.sort()
for i in 0..<cnt {
    print(reps[i])
}


func floydWarshall(size: Int) {
    for k in 1...size {
        for i in 1...size {
            for j in 1...size {
                if arr[i][j] > (arr[i][k] + arr[k][j]) {
                    arr[i][j] = arr[i][k] + arr[k][j]
                }
            }
        }
    }
}

func calMaxDist(size: Int) {
    for i in 1...size {
        for j in 1...size {
            if arr[i][j] != maxWeight {
                if maxDist[i] < arr[i][j] {
                    maxDist[i] = arr[i][j]
                }
            }
        }
    }
}

func findRep(size: Int) {
    var visit: [Bool] = Array(repeating: false, count: N+1)
    
    for i in 1...size {
        if !visit[i] {
            visit[i] = true
            var candidate = i
            for j in 1...size {
                if arr[i][j] != maxWeight && i != j {
                    visit[j] = true
                    if maxDist[candidate] > maxDist[j] {
                        candidate = j
                    }
                }
            }
            reps.append(candidate)
            cnt += 1
        }
    }
}
