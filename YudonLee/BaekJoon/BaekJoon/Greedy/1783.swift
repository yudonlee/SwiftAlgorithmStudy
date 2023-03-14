//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2023/03/14.
//

//1783번
//병든 나이트가 N × M 크기 체스판의 가장 왼쪽아래 칸에 위치해 있다. 병든 나이트는 건강한 보통 체스의 나이트와 다르게 4가지로만 움직일 수 있다.
//
//2칸 위로, 1칸 오른쪽
//1칸 위로, 2칸 오른쪽
//1칸 아래로, 2칸 오른쪽
//2칸 아래로, 1칸 오른쪽
//병든 나이트는 여행을 시작하려고 하고, 여행을 하면서 방문한 칸의 수를 최대로 하려고 한다. 병든 나이트의 이동 횟수가 4번보다 적지 않다면, 이동 방법을 모두 한 번씩 사용해야 한다. 이동 횟수가 4번보다 적은 경우(방문한 칸이 5개 미만)에는 이동 방법에 대한 제약이 없다.
//
//체스판의 크기가 주어졌을 때, 병든 나이트가 여행에서 방문할 수 있는 칸의 최대 개수를 구해보자.

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
//
let N = FIO.readInt()
let M = FIO.readInt()

func solution(_ N:Int, _ M: Int) -> Int {
    if N >= 3 {
        if M > 4 {
            return max((M - 2), 4)
        } else {
            return M
        }
    } else if N == 2 {
        return min((M - 1) / 2 + 1, 4)
    } else if N == 1 {
        return 1
    }
    return 0
}

print(solution(N, M))
//print(solution(100, 50))
//print(solution(1, 1))
//print(solution(17, 5))
//print(solution(2, 4))
//print(solution(20, 4))
//
