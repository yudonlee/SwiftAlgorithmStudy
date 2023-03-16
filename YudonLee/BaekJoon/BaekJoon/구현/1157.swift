//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2023/03/15.
//

//1157
//알파벳 대소문자로 된 단어가 주어지면, 이 단어에서 가장 많이 사용된 알파벳이 무엇인지 알아내는 프로그램을 작성하시오. 단, 대문자와 소문자를 구분하지 않는다.


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

//func solution(_ input: String) -> String {
//    var letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".map { String($0) }
//    var count = Array(repeating: 0, count: 26)
//    let upper = input.uppercased()
//    upper.forEach {
//        let index = Int($0.asciiValue! - Character("A").asciiValue!)
//        count[index] += 1
//    }
//
//    var max = -1
//    var maxItemCount = 0
//    var maxChar = "?"
//    for item in count.enumerated() {
//        if max < item.element {
//            maxItemCount = 1
//            maxChar = letters[item.offset]
//            max = item.element
//        } else if max == item.element {
//            maxItemCount += 1
//
//        }
//    }
//
//    if maxItemCount > 1 {
//        return "?"
//    }
//    return maxChar
//}

func solution(_ input: String) -> String {
    var alphabetCount: [String:Int] = [:]
    var revAlpha: [Int:[String]] = [:]

    input.uppercased().forEach {
        alphabetCount[String($0), default: 0] += 1
    }

    alphabetCount.forEach {
        revAlpha[$1, default: []].append($0)
    }
    let top = revAlpha.sorted { $0.key > $1.key }[0].value
    return top.count < 2 ? top[0] : "?"
}

print(solution(FIO.readString()))

