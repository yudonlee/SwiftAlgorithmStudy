//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2023/03/16.
//

// 14719
//첫 번째 줄에는 2차원 세계의 세로 길이 H과 2차원 세계의 가로 길이 W가 주어진다. (1 ≤ H, W ≤ 500)
//
//두 번째 줄에는 블록이 쌓인 높이를 의미하는 0이상 H이하의 정수가 2차원 세계의 맨 왼쪽 위치부터 차례대로 W개 주어진다.
//
//따라서 블록 내부의 빈 공간이 생길 수 없다. 또 2차원 세계의 바닥은 항상 막혀있다고 가정하여도 좋다.

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

func solution(_ h: Int, _ w: Int ) -> Int {
    var board = Array(repeating: Array(repeating: 0, count: w), count: h)
    var result = 0
    
    for col in 0..<w {
        let range = FIO.readInt()
        for row in stride(from: h - 1, to: h - 1 - range, by: -1) {
            board[row][col] = 1
        }
    }
    
    for row in 0..<h {
        var start = -1
        var end = -1
        
        for col in 0..<w {
            if board[row][col] != 0 {
                if start == -1 {
                    start = col
                } else if end == -1 {
                    end = col
                    result += end - start - 1
                    start = col
                    end = -1
                }
            }
        }
        
//        if start != -1, end != -1 {
//            result += end - start - 1
//        }
    }
    return result
}

print(solution(FIO.readInt(), FIO.readInt()))
//5 9
//5 0 2 0 5 0 0 0 1
