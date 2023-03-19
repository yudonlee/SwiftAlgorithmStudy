//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2023/03/17.
//

import Foundation

//1244
//1부터 연속적으로 번호가 붙어있는 스위치들이 있다. 스위치는 켜져 있거나 꺼져있는 상태이다. <그림 1>에 스위치 8개의 상태가 표시되어 있다. ‘1’은 스위치가 켜져 있음을, ‘0’은 꺼져 있음을 나타낸다. 그리고 학생 몇 명을 뽑아서, 학생들에게 1 이상이고 스위치 개수 이하인 자연수를 하나씩 나누어주었다. 학생들은 자신의 성별과 받은 수에 따라 아래와 같은 방식으로 스위치를 조작하게 된다.
//
//남학생은 스위치 번호가 자기가 받은 수의 배수이면, 그 스위치의 상태를 바꾼다. 즉, 스위치가 켜져 있으면 끄고, 꺼져 있으면 켠다. <그림 1>과 같은 상태에서 남학생이 3을 받았다면, 이 학생은 <그림 2>와 같이 3번, 6번 스위치의 상태를 바꾼다.
//
//여학생은 자기가 받은 수와 같은 번호가 붙은 스위치를 중심으로 좌우가 대칭이면서 가장 많은 스위치를 포함하는 구간을 찾아서, 그 구간에 속한 스위치의 상태를 모두 바꾼다. 이때 구간에 속한 스위치 개수는 항상 홀수가 된다.

//8
//0 1 0 1 0 0 0 1
//2
//1 3
//2 3

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

func solution(_ N: Int) -> String {
    var switches = Array(repeating: false, count: N + 1)
    (1...N).forEach { switches[$0] = (FIO.readInt() == 1) }
    
    for _ in 0..<FIO.readInt() {
        let gender = FIO.readInt()
        let number = FIO.readInt()
        
        if gender == 1 {
            var idx = 1
            while(idx * number <= N) {
                switches[idx * number].toggle()
                idx += 1
            }
        } else {
            switches[number].toggle()
            for i in stride(from: 1, through: min(number - 1, N - number), by: +1) {
                if switches[number + i] == switches[number - i] {
                    switches[number + i].toggle()
                    switches[number - i].toggle()
                } else {
                    break
                }
            }
        }
    }
    
    var result = ""
    var count = 0
    (1...N).forEach {
        if switches[$0] {
            result += "1 "
        } else {
            result += "0 "
        }
        count += 1
        if count == 20 {
            count = 0
            result += "\n"
        }
    }
    
    return result
}

print(solution(FIO.readInt()))


//8
//0 1 0 1 0 0 0 1
//2
//1 3
//2 3
