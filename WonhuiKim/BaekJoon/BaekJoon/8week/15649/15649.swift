//
//  15649.swift N과M(1) backtracking
//  BaekJoon
//
//  Created by 김원희 on 2022/07/19.
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
let N = FIO.readInt() //1~N
let M = FIO.readInt() //선택해야할 개수

var visit: [Bool] = Array(repeating: false, count: N+1)
var answer: [Int] = Array(repeating: 0, count: M)

bt(depth: 0)

func bt(depth: Int) {
    if depth == M {
        for i in answer {
            print(i, terminator: " ")
        }
        print()
        return
    }
    
    for i in 1...N {
        if !visit[i] {
            visit[i] = true
            answer[depth] = i
            bt(depth: depth+1)
            visit[i] = false
        }
    }
}


