//
//  1717.swift 집합의 표현 (Disjoint set)
//  BaekJoon
//
//  Created by 김원희 on 2022/07/05.
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

let n = FIO.readInt()
let m = FIO.readInt()

var parent = [Int]()
for i in 0...n {
    parent.append(i)
}

for _ in 0..<m {
    let flag = FIO.readInt()
    let a = FIO.readInt()
    let b = FIO.readInt()
    
    if flag == 0 { //UNION
        UNION(a: a, b: b)
    } else { //flag == 1 -> FIND
        FIND(node: a) == FIND(node: b) ? print("YES") : print("NO")
    }
    
}

func FIND(node: Int) -> Int {
    if node == parent[node] {
        return node
    }
    
    parent[node] = FIND(node: parent[node])
    
    return parent[node]
}

func UNION(a: Int, b: Int) {
    let a = FIND(node: a)
    let b = FIND(node: b)
    
    parent[b] = a
}



