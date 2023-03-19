//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2023/03/19.
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

struct Stack<T> {
    var arr: [T] = []
    
    func isEmpty() -> Bool {
        return arr.isEmpty
    }
    
    mutating func push(element: T) {
        arr.append(element)
    }
    
    mutating func pop() -> T {
        return arr.removeLast()
    }
}

struct UnitCase {
    let currentIdx: Int
    let currentItem: [Int]
}
func combination() -> [[Int]] {
    var stack = Stack<UnitCase>()
    var result = [[Int]]()
    stack.push(element: UnitCase(currentIdx: 0, currentItem: []))
    
    while !stack.isEmpty() {
        let top = stack.pop()
        
        if top.currentItem.count == 7 {
            result.append(top.currentItem)
            continue
        }
        
        if top.currentIdx >= 25 || top.currentItem.count + 25 - top.currentIdx + 1 < 7 {
            continue
        }
        
        
        var traces = top.currentItem
        traces.append(top.currentIdx)
        
        
        stack.push(element: UnitCase(currentIdx: top.currentIdx + 1, currentItem: top.currentItem))
        stack.push(element: UnitCase(currentIdx: top.currentIdx + 1, currentItem: traces))
    }
    return result
}

let dx = [0, 0, 1, -1]
let dy = [1, -1, 0, 0]
func solution(board: [[String]]) -> Int {
    let allCases = combination()
    let visited = Array(repeating: Array(repeating: false, count: 5), count: 5)
    var result = 0
    allCases.forEach { unitCase in
        var visited = visited
        var yMemberCount = 0
        unitCase.forEach {
            let row = $0 / 5
            let col = $0 % 5
            visited[row][col] = true
            yMemberCount += board[row][col] == "Y" ? 1 : 0
        }
        
        if yMemberCount > 3 {
            return
        }
        var stack: [Int] = []
        stack.append(unitCase.first!)
        var count = 0
        while !stack.isEmpty {
            let top = stack.removeLast()
            if visited[top / 5][top % 5] {
                visited[top / 5][top % 5] = false
                count += 1
                
                for idx in 0...3 {
                    let nextRow = top / 5 + dy[idx]
                    let nextCol = top % 5 + dx[idx]
                    if 0 <= nextRow, nextRow < 5, 0 <= nextCol, nextCol < 5{
                        if visited[nextRow][nextCol]  {
                            stack.append(5 * nextRow + nextCol)
                        }
                    }
                }
            }
        }
        
        if count == 7 {
            result += 1
        }
        
    }

    return result
}

var board = Array(repeating: Array(repeating: "Y", count: 5), count: 5)
for row in 0...4 {
    let str = FIO.readString()
    let aa = Array(str)
    
    for col in 0...4 {
        board[row][col] = String(aa[col])
    }
    
}

print(solution(board: board))

//YYYYY
//SYSYS
//YYYYY
//YSYYS
//YYYYY
