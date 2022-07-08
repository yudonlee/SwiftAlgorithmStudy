//
//  14595.swift 동방 (disjoint set)
//  BaekJoon
//
//  Created by 김원희 on 2022/07/07.
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
let N = FIO.readInt()

var parent = [Int]()
for i in 0...N {
    parent.append(i)
}

let M = FIO.readInt()

for _ in 0..<M {
    let a = FIO.readInt()
    let b = FIO.readInt()
    
    UNION(a: a, b: b)
}


var result = 0
var max = FIND(node: 1)
if max == 1 {
    result = 1
}

for i in 2...N {
    if max <= FIND(node: i) {
        if i == FIND(node: i) {
            result += 1
        }
        max = FIND(node: i)
    }
}
print(result)

func FIND(node: Int) -> Int {
    if node == parent[node] {
        return node
    }
    
    parent[node] = FIND(node: parent[node])
    return parent[node]
}

func UNION(a: Int, b: Int) {
    let root_a = FIND(node: a)
    let root_b = FIND(node: b)
    
    if parent[root_a] < root_b {
        parent[root_a] = root_b
    }
}
