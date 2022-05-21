//
//  1012.swift 유기농배추
//  BaekJoon
//
//  Created by 김원희 on 2022/05/21.
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
var M: Int = 0
var N: Int = 0
var K: Int = 0
var arr: [[Int]] = [[0]]
var visit: [[Bool]] = [[false]]
var cnt: Int = 0

let dx = [-1, 0, 1, 0]
let dy = [0, -1, 0, 1]

let T = FIO.readInt() //테스트케이스 개수 2

for _ in 0..<T {
    M = FIO.readInt() //가로 10
    N = FIO.readInt() //세로 8
    K = FIO.readInt() //위치 개수 17
    arr = Array(repeating: Array(repeating: 0, count: N), count: M)
    visit = Array(repeating: Array(repeating: false, count: N), count: M)
    
    for _ in 0..<K {
        let first = FIO.readInt()
        let second = FIO.readInt()
        arr[first][second] = 1
    }
    
    cnt = 0
    
    for i in 0..<M {
        for j in 0..<N {
            dfs(x: i, y: j)
        }
    }
    
    print(cnt)
}

func dfs(x: Int, y: Int) {
    var stack = [(Int, Int)]()
    
    if arr[x][y] == 1 && !visit[x][y] {
        stack.append((x, y))
        
        while(!stack.isEmpty) {
            let current = stack.popLast()!
            
            if !visit[current.0][current.1] {
                visit[current.0][current.1] = true
                
                for i in 0..<4 {
                    let nextX = current.0 + dx[i]
                    let nextY = current.1 + dy[i]
                    
                    if nextX < 0 || nextX >= M || nextY < 0 || nextY >= N {
                        continue
                    }
                    
                    if arr[nextX][nextY] == 1 && !visit[nextX][nextY] {
                        stack.append((nextX, nextY))
                    }
                }
            }
        }
        cnt += 1
    }
}
