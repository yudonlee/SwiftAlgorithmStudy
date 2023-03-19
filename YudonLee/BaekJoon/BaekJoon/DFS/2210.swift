//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2023/03/18.
//

//2210 
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

var dx = [0, 0, 1, -1]
var dy = [1, -1, 0, 0]
var visitied = Array(repeating: false, count: 1000000)
var count = 0

func dfs(_ board: [[Int]], _ row: Int, _ col: Int, numbers: [Int]) {
    let value = board[row][col]
    var appended = numbers
    appended.append(value)
    
    if appended.count == 6 {
        var values: String = ""
        appended.forEach { values += "\($0)" }
        if !visitied[Int(values)!] {
            count += 1
            visitied[Int(values)!] = true
        }
        return
    }
    
    for i in 0...3 {
        if 0 <= row + dy[i], row + dy[i] < 5, 0 <= col + dx[i], col + dx[i] < 5 {
            dfs(board, row + dy[i], col + dx[i], numbers: appended)
        }
    }
}

var board = Array(repeating: Array(repeating: 0, count: 5), count: 5)
for row in 0...4 {
    for col in 0...4 {
        board[row][col] = FIO.readInt()
    }
}

for row in 0...4 {
    for col in 0...4 {
        dfs(board, row, col, numbers: [])
    }
}
print(count)



