//
//  1535.swift 안녕 (Knapsack)
//  BaekJoon
//
//  Created by 김원희 on 2022/07/12.
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
let N = FIO.readInt() //사람 수 3
let fullEngergy = 100 //체력 100

var energy: [Int] = Array(repeating: 0, count: N+1) //체력
var joy: [Int] = Array(repeating: 0, count: N+1) //기쁨

for i in 1...N {
    energy[i] = FIO.readInt() //체력
}
for i in 1...N {
    joy[i] = FIO.readInt() //기쁨
}

var DP: [[Int]] = Array(repeating: Array(repeating: 0, count: fullEngergy), count: N+1)
for i in 1...N {
    for j in 1..<fullEngergy {
        if energy[i] <= j {
            if (DP[i-1][j-energy[i]]+joy[i]) > DP[i-1][j] {
                DP[i][j] = DP[i-1][j-energy[i]]+joy[i]
            } else {
                DP[i][j] = DP[i-1][j]
            }
        } else {
            DP[i][j] = DP[i-1][j]
        }
    }
}

print(DP[N][fullEngergy-1])




