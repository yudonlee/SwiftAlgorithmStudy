//
//  9084.swift 동전 knapsack
//  BaekJoon
//
//  Created by 김원희 on 2022/07/17.
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

let T = FIO.readInt() //테스트케이스 수

for _ in 0..<T {
    let N = FIO.readInt() //동전 가지수
    
    var coin = [Int]()
    for _ in 0..<N {
        coin.append(FIO.readInt()) //coin 1 ~ N 저장
    }
    
    let M = FIO.readInt() //만들어야 할 금액
    var DP: [Int] = Array(repeating: 0, count: M+1)
    
    DP[0] = 1
    for i in 0..<N {
        if coin[i] < M {
            for j in coin[i]...M {
                DP[j] += DP[j-coin[i]]
            }
        }
    }
    print(DP[M])
}

