//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2023/03/18.
//

import Foundation


//1941


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

var start = Array(repeating: Array(repeating: false, count: 5), count: 5)

var dy = [0, 0, 1, -1]
var dx = [1, -1, 0, 0]
var allCases = [[(Int, Int)]]()
func dfs(_ row: Int, _ col: Int) {
    start[row][col] = true
    var stack = Stack<(Int, Int, [(Int, Int)], visited: [[Bool]])>()
    var visitied = Array(repeating: Array(repeating: false, count: 5), count: 5)
    stack.push(element: (row, col, [], visitied))
    
    while !stack.isEmpty() {
        let top = stack.pop()
        var appendVisit = top.visited
        appendVisit[top.0][top.1] = true
        var appendedVisitArray = top.2
        appendedVisitArray.append((top.0, top.1))
        
        
        if appendedVisitArray.count == 7 {
            appendedVisitArray.sorted { leftValue, rightValue in
                if leftValue.0 < rightValue.0 {
                    return true
                } else if leftValue.0 == rightValue.0 == 0 {
                    if leftValue.1 < rightValue.1 {
                        return true
                    }
                }
                return false
            }
            allCases.append(appendedVisitArray)
            continue
        }
        
        
        for next in appendedVisitArray {
            for idx in 0...3 {
                let nextRow = next.0 + dy[idx]
                let nextCol = next.1 + dx[idx]
                
                if 0 <= nextRow, nextRow < 5, 0 <= nextCol, nextCol < 5 {
                    if !start[nextRow][nextCol], !appendVisit[nextRow][nextCol] {
                        stack.push(element: (nextRow, nextCol, appendedVisitArray, appendVisit))
                    }
                }
            }
        }
        
    }
    
}
func solution(_ board: [[String]]) -> Int {
    var count = 0
    for row in 0...4 {
        for col in 0...4 {
            dfs(row, col)
        }
    }
    
    let allCases = Set<[(Int, Int)]>(
    allCases.forEach {
        var yMemberCount = 0
        for item in $0 {
            yMemberCount += board[item.0][item.1] == "Y" ? 1 : 0
        }
        if yMemberCount <= 3 {
            count += 1
        }
    }
    return count
}

var board = Array(repeating: Array(repeating: "Y", count: 5), count: 5)
for row in 0...4 {
    let str = FIO.readString()
    let aa = Array(str)
    
    for col in 0...4 {
        board[row][col] = String(aa[col])
    }
    
}


print(solution(board))
print(allCases.count)


//YYYYY
//SYSYS
//YYYYY
//YSYYS
//YYYYY
