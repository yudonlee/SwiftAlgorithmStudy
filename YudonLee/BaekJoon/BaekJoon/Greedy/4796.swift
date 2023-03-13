//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2023/03/13.
//

import Foundation

// 백준 4796
//
//등산가 김강산은 가족들과 함께 캠핑을 떠났다. 하지만, 캠핑장에는 다음과 같은 경고문이 쓰여 있었다.
//
//캠핑장은 연속하는 20일 중 10일동안만 사용할 수 있습니다.
//
//강산이는 이제 막 28일 휴가를 시작했다. 이번 휴가 기간 동안 강산이는 캠핑장을 며칠동안 사용할 수 있을까?
//
//강산이는 조금 더 일반화해서 문제를 풀려고 한다.
//
//캠핑장을 연속하는 P일 중, L일동안만 사용할 수 있다. 강산이는 이제 막 V일짜리 휴가를 시작했다. 강산이가 캠핑장을 최대 며칠동안 사용할 수 있을까? (1 < L < P < V)

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

func solution(_ L: Int64, _ P: Int64, _ V: Int64) -> Int64 {
    let remainder = V % P
    let divide = (V / P) * L
    if remainder > L {
        return L + divide
    } else {
        return divide + remainder
        
    }
}

var count = 1
while true {
    let L = Int64(FIO.readString())!
    let P = Int64(FIO.readString())!
    let V = Int64(FIO.readString())!
    
    if L == 0, P == 0, V == 0 {
        break
    } else {
        print("Case \(count): \(solution(Int64(L), Int64(P), Int64(V)))")
    }
    count += 1
    
}

//776357247 1076006024 2003512866


