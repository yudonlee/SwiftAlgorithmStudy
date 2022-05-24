//
//  7576.swift 토마토
//  BaekJoon
//
//  Created by 김원희 on 2022/05/24.
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

let M = FIO.readInt() //가로
let N = FIO.readInt() //세로

var tomatoBox: [[Int]] = Array(repeating: Array(repeating: -1, count: M+2), count: N+2)
var dist: [[Int]] = Array(repeating: Array(repeating: -2, count: M+2), count: N+2)
var visit: [[Bool]] = Array(repeating: Array(repeating: false, count: M+2), count: N+2)

let dx = [-1, 0, 1, 0]
let dy = [0, -1, 0, 1]

struct Queue<T> {
    private var queue = [T]()
    var front: Int = 0
    
    public var isEmpty: Bool {
        let rear = queue.count - 1
        
        if rear < front {
            return true
        }
        
        return false
    }
    
    public mutating func add(_ element: T) {
        queue.append(element)
    }
    
    public mutating func top() -> T?{
        return isEmpty ? nil : queue[front]
    }
    
    public mutating func offer() {
        front += 1
    }
}

var queue = Queue<(Int, Int)>()

for i in 1..<N+1 {
    for j in 1..<M+1 {
        tomatoBox[i][j] = FIO.readInt()
        if tomatoBox[i][j] == 1 {
            queue.add((i, j))
            dist[i][j] = 0
            visit[i][j] = true
        }
        
        if(tomatoBox[i][j] == -1) {
            dist[i][j] = -1
        }
    }
}


while(!queue.isEmpty) {
    
    if let cur = queue.top() {
        queue.offer()
        
        for i in 0..<4 {
            let nextX = cur.0 + dx[i]
            let nextY = cur.1 + dy[i]
            
            if tomatoBox[nextX][nextY] != -1 && !visit[nextX][nextY] {
                queue.add((nextX, nextY))
                visit[nextX][nextY] = true
                dist[nextX][nextY] = dist[cur.0][cur.1] + 1
            }
        }
    }
}

var isIsolated = false

var max = -1
for i in 1..<N+1 {
    for j in 1..<M+1 {
        if dist[i][j] == -2 {
            isIsolated = true
        }
        if dist[i][j] > max {
            max = dist[i][j]
        }
    }
}

if isIsolated == true {
    print(-1)
} else {
    print(max)
}
