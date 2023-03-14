//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2023/03/13.
//

import Foundation

//어느 날, 미르코는 우연히 길거리에서 양수 N을 보았다. 미르코는 30이란 수를 존경하기 때문에, 그는 길거리에서 찾은 수에 포함된 숫자들을 섞어 30의 배수가 되는 가장 큰 수를 만들고 싶어한다.
//
//미르코를 도와 그가 만들고 싶어하는 수를 계산하는 프로그램을 작성하라

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

var x = FIO.readString()
var numbers = Array(repeating: 0, count: 10)
let total = x.reduce(into: 0) { partialResult, char in
    partialResult += Int(String(char))!
    numbers[Int(String(char))!] += 1
}

var result = ""
if total % 3 == 0, x.contains("0") {
    for index in (0...9).reversed() {
        while(numbers[index] > 0) {
            result += "\(index)"
            numbers[index] -= 1
        }
    }
    print(result)
    
} else {
    print("-1")
}
