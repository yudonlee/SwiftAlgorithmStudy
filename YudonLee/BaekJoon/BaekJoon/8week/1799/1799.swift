//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/07/15.
//

import Foundation

final class FileIO {
    private let buffer:[UInt8]
    private var index: Int = 0

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        
        buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }

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
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
    }

    @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return Array(buffer[beginIndex..<(index-1)])
    }
}

struct Bishop {
    var row: Int
    var col: Int
}

enum Status: Int {
    case Block = 0
    case Open = 1
    case OnBishop = 2
}

let fio = FileIO()
let N = fio.readInt()
var board = Array(repeating: Array(repeating: -1, count: N + 2), count: N + 2)
var isBishop: [Bishop] = []
var isBishopEven: [Bishop] = []
var rowBishop: [[Bishop]] = Array(repeating: [], count: N + 1)
var result = 0
var dx = [1, -1]
var dy = [-1, -1]

func isDigonalExist(board: [[Int]], row: Int, col: Int) -> Bool {
    if row == 1 {
        return false
    }
    for r in 1...row - 1 {
        for rbs in rowBishop[r] {
            let preRow = row - rbs.row
            let preCol = col - rbs.col
            if abs(preRow) == abs(preCol) {
                if board[rbs.row][rbs.col] == Status.OnBishop.rawValue {
                    return true
                }
            }
        }
    }
    return false
}
func backTracking(current: Int, finalDest: Int, isBishop: [Bishop], count: Int, board: [[Int]]) {
    if current == finalDest {
        result = max(count, result)
        return
    }
    
    if finalDest - current + count < result {
        return
    }
    
    let top = isBishop[current]
    var copiedBoard = board
    var anotherCopiedBoard = board
    
    
    if !isDigonalExist(board: copiedBoard, row: top.row, col: top.col), copiedBoard[top.row][top.col] == Status.Open.rawValue {
        copiedBoard[top.row][top.col] = Status.OnBishop.rawValue
        backTracking(current: current + 1, finalDest: finalDest, isBishop: isBishop,count: count + 1, board: copiedBoard)
    }
    
    backTracking(current: current + 1, finalDest: finalDest, isBishop: isBishop, count: count, board: anotherCopiedBoard)
}


for i in 1...N {
    for j in 1...N {
        board[i][j] = fio.readInt()
        if board[i][j] == 1 {
            if j % 2 == 1 {
                if i % 2 == 1 {
                    isBishop.append(Bishop(row: i, col: j))
                } else {
                    isBishopEven.append(Bishop(row: i, col: j))
                }
            } else {
                if i % 2 == 1 {
                    isBishopEven.append(Bishop(row: i, col: j))
                } else {
                    isBishop.append(Bishop(row: i, col: j))
                }
            }
            rowBishop[i].append(Bishop(row: i, col: j))
        }
    }
}

backTracking(current: 0, finalDest: isBishop.count, isBishop: isBishop, count: 0, board: board)
let archive = result
result = 0
backTracking(current: 0, finalDest: isBishopEven.count, isBishop: isBishopEven, count: 0, board: board)

print(result + archive)
