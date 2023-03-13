//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2023/03/13.
//

import Foundation

//항승이는 품질이 심각하게 나쁜 수도 파이프 회사의 수리공이다. 항승이는 세준 지하철 공사에서 물이 샌다는 소식을 듣고 수리를 하러 갔다.
//
//파이프에서 물이 새는 곳은 신기하게도 가장 왼쪽에서 정수만큼 떨어진 거리만 물이 샌다.
//
//항승이는 길이가 L인 테이프를 무한개 가지고 있다.
//
//항승이는 테이프를 이용해서 물을 막으려고 한다. 항승이는 항상 물을 막을 때, 적어도 그 위치의 좌우 0.5만큼 간격을 줘야 물이 다시는 안 샌다고 생각한다.
//
//물이 새는 곳의 위치와, 항승이가 가지고 있는 테이프의 길이 L이 주어졌을 때, 항승이가 필요한 테이프의 최소 개수를 구하는 프로그램을 작성하시오. 테이프를 자를 수 없고, 테이프를 겹쳐서 붙이는 것도 가능하다.
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

let N = FIO.readInt()
let L = FIO.readInt()
var leaks = [Int]()
var pipes = Array(repeating: 1, count: 1001)

(0..<N).forEach { _ in
    let x = FIO.readInt()
    leaks.append(x)
    pipes[x] = 0
}

var count = 0
leaks.sort()

leaks.forEach {
    if pipes[$0] == 0 {
        count += 1
        var length = L
        while length > 0,  $0 + (L - length) <= 1000 {
            pipes[$0 + (L - length)] = 1
            length -= 1
        }
    }
}

print(count)
