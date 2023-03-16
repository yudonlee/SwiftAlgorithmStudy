//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2023/03/15.
//

import Foundation

//16926
//문제
//크기가 N×M인 배열이 있을 때, 배열을 돌려보려고 한다. 배열은 다음과 같이 반시계 방향으로 돌려야 한다.
//
//A[1][1] ← A[1][2] ← A[1][3] ← A[1][4] ← A[1][5]
//   ↓                                       ↑
//A[2][1]   A[2][2] ← A[2][3] ← A[2][4]   A[2][5]
//   ↓         ↓                   ↑         ↑
//A[3][1]   A[3][2] → A[3][3] → A[3][4]   A[3][5]
//   ↓                                       ↑
//A[4][1] → A[4][2] → A[4][3] → A[4][4] → A[4][5]
//예를 들어, 아래와 같은 배열을 2번 회전시키면 다음과 같이 변하게 된다.
//
//1 2 3 4       2 3 4 8       3 4 8 6
//5 6 7 8       1 7 7 6       2 7 8 2
//9 8 7 6   →   5 6 8 2   →   1 7 6 3
//5 4 3 2       9 5 4 3       5 9 5 4
// <시작>         <회전1>        <회전2>
//배열과 정수 R이 주어졌을 때, 배열을 R번 회전시킨 결과를 구해보자.

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


func solution(_ board: [[Int]], _ N: Int, _ M: Int, _ R: Int) -> [[Int]] {
    if M < 2 {
        return board
    }
    
//    var newBoard = Array(repeating: Array(repeating: 0, count: M), count: N)
    var newBoard = board
    for i in 0..<min(N, M) {
        if (N - 1) - i  <= i || (M - 1) - i <= i {
            break
        }
        var total = [Int]()
        
        for row in stride(from: i, through: (N - 1) - i - 1, by: +1) {
            total.append(board[row][i])
        }
        
        for col in stride(from: i, through: (M - 2 - i), by: +1) {
            total.append(board[N - 1 - i][col])
        }
        
        for row in stride(from: N - 1 - i, through: i + 1, by: -1) {
            total.append(board[row][M - 1 - i])
        }
        
        for col in stride(from: M - 1 - i, through: 1 + i, by: -1) {
            total.append(board[i][col])
        }
        
        var convertedTotal = Array(repeating: 0, count: total.count)
        
        for idx in 0..<total.count {
            let convertedIdx = (idx + (R % total.count)) % total.count
            convertedTotal[convertedIdx] = total[idx]
        }
        
        for row in stride(from: i, through: (N - 1) - i - 1, by: +1) {
            newBoard[row][i] = convertedTotal.removeFirst()
        }
        
        for col in stride(from: i, through: (M - 2 - i), by: +1) {
            newBoard[N - 1 - i][col] = convertedTotal.removeFirst()
        }
        
        for row in stride(from: N - 1 - i, through: i + 1, by: -1) {
            newBoard[row][M - 1 - i] = convertedTotal.removeFirst()
        }
        
        for col in stride(from: M - 1 - i, through: 1 + i, by: -1) {
            newBoard[i][col] = convertedTotal.removeFirst()
        }
        
    }
    
    return newBoard
}


let N = FIO.readInt()
let M = FIO.readInt()
let R = FIO.readInt()

var board = Array(repeating: Array(repeating: 0, count: M), count: N)
for row in 0..<N {
    for col in 0..<M {
        board[row][col] = FIO.readInt()
    }
}

let result = solution(board, N, M, R)

for row in 0..<N {
    for col in 0..<M {
        print((result[row][col]), terminator: " ")
    }
    print("")
}


