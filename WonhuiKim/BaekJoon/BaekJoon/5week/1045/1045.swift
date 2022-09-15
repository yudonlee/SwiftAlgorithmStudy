//
//  1045.swift 도로 (MST)
//  BaekJoon
//
//  Created by 김원희 on 2022/07/11.
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
let N = FIO.readInt() //도시(정점) 수
var M = FIO.readInt() //도로(간선) 수

var parent: [Int] = Array(repeating: 0, count: N)
for i in 1..<N {
    parent[i] = i
}

var pq = [(Int, Int)]()

var cities: [[String]] = Array(repeating: Array(repeating: " ", count: N), count: N)
for i in 0..<N {
    let str = FIO.readString().map { String($0) } //map과 { 사이 띄어쓰기!!
    for j in i+1..<N {
        cities[i][j] = str[j]
        if cities[i][j] == "Y" {
            pq.append((i, j))
        }
    }
}

var linked: [Int] = Array(repeating: 0, count: N)
var cntEdge = 0
var left = [(Int, Int)]()
for now in pq {
    if FIND(node: now.0) != FIND(node: now.1) {
        UNION(a: now.0, b: now.1)
        linked[now.0] += 1
        linked[now.1] += 1
        cntEdge += 1
    } else {
        left.append((now.0, now.1))
    }
}

var snap = false
if N-1 != cntEdge { //MST 아닌 경우
    snap = true
}

var additional = M - (N-1)
for now in left {
    if additional == 0 {
        //snap = true
        break
    }
    if additional < 0 {
        snap = true
        break
    }
    linked[now.0] += 1
    linked[now.1] += 1
    additional -= 1
}

if additional > 0 {
    snap = true
}

let std = FIND(node: 0)
for i in 1..<N {
    if std != FIND(node: i) {
        snap = true
        break
    }
}

if snap {
    print(-1)
} else {
    for l in linked {
        print(l, terminator: " ")
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
    let root_a = FIND(node: a)
    let root_b = FIND(node: b)
    
    if root_a < root_b {
        parent[root_b] = root_a
    } else {
        parent[root_a] = root_b
    }
}

