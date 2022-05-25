//
//  2644.swift 촌수계산
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

let n = FIO.readInt() //전체 사람 수
var relation: [[Int]] = Array(repeating: Array(repeating: 0, count: n+1), count: n+1)
var visit: [Int] = Array(repeating: 0, count: n+1)

//촌수 계산해야하는 두 사람
let from = FIO.readInt()
let to = FIO.readInt()

let tc = FIO.readInt() //관계 개수

for _ in 0..<tc {
    let first = FIO.readInt()
    let second = FIO.readInt()
    
    relation[first][second] = 1
    relation[second][first] = 1
}

print(dfs(from: from, to: to))
//bfs(from: from, to: to)

struct Queue<T> {
    private var queue = [T]()
    
    var front = 0
    
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
    
    public mutating func top() -> T? {
        return isEmpty ? nil : queue[front]
    }
    
    public mutating func pop() {
        front += 1
    }
}

struct Stack<T> {
    private var stack = [T]()
    
    public var isEmpty: Bool {
        return stack.isEmpty
    }
    
    public mutating func push(_ element: T) {
        stack.append(element)
    }
    
    public mutating func pop() -> T? {
        return isEmpty ? nil : stack.popLast()
    }
}

func dfs(from: Int, to: Int) -> Int{
    var stack = Stack<Int>()
    
    stack.push(from)

    while(!stack.isEmpty) {
        if let cur = stack.pop() {
            
            if cur == to {
                return visit[to]
            }
            
            for i in 1...n {
                if visit[i] == 0 && relation[cur][i] == 1 {
                    stack.push(i)
                    visit[i] = visit[cur] + 1
                }
            }
        }
    }
    
    return -1
}
