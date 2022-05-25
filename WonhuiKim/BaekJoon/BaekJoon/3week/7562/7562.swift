//
//  7562.swift 나이트의 이동
//  BaekJoon
//
//  Created by 김원희 on 2022/05/25.
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

let dx = [1, 2, 2, 1, -1, -2, -2, -1]
let dy = [2, 1, -1, -2, -2, -1, 1, 2]

let tc = FIO.readInt()

for _ in 0..<tc {
    let l = FIO.readInt() //체스판 한 변의 길이
    
    let startX = FIO.readInt()
    let startY = FIO.readInt()
    
    let finishX = FIO.readInt()
    let finishY = FIO.readInt()
    
    var dist: [[Int]] = Array(repeating: Array(repeating: -1, count: l), count: l)
    
    func bfs(sx: Int, sy: Int, fx: Int, fy: Int) {
        var queue = Queue<(Int, Int)>()
        var found = false
        
        queue.add((sx, sy))
        dist[sx][sy] = 0
        
        while(!queue.isEmpty && !found) {
            if let cur = queue.top() {
                queue.pop()
                
                if cur.0 == fx && cur.1 == fy {
                    found = true
                }
                
                for i in 0..<8 {
                    let nextX = cur.0 + dx[i]
                    let nextY = cur.1 + dy[i]
                    
                    if nextX < 0 || nextX >= l || nextY < 0 || nextY >= l {
                        continue
                    }
                    
                    if dist[nextX][nextY] == -1 {
                        queue.add((nextX, nextY))
                        dist[nextX][nextY] = dist[cur.0][cur.1] + 1
                    }
                }
            }
        }
    }
    
    bfs(sx: startX, sy: startY, fx: finishX, fy: finishY)
    print(dist[finishX][finishY])
}



struct Queue<T> {
    private var queue = [T]()
    
    var front = 0
    
    public var isEmpty: Bool {
        let rear = queue.count - 1
        
        if front > rear {
            return true
        }
        return false
    }
    
    public mutating func add(_ element: T) {
        queue.append(element)
    }
    
    public func top() -> T? {
        return isEmpty ? nil : queue[front]
    }
    
    public mutating func pop() {
        front += 1
    }
}
