//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/05/17.
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

func lowerBound(arr: [Int], find: Int) -> Int {
    var left: Int = 0
    var right: Int = arr.count - 1
    while(left <= right) {
        let mid: Int = (left + right) / 2
        
        if(arr[mid] >= find) {
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    return left
}

let FIO = FileIO()


while let line = readLine() {
//    print(line)
    let N: Int = Int(line)!
//    print(N)
    var arr: [Int] = readLine()!.components(separatedBy: " ").map({ Int($0)!})
//    print(arr)

    var result: [Int] = []

    for items in arr {
        let index: Int = lowerBound(arr: result, find: items)
        if(index == result.count) {
            result.append(items)
        } else {
            result[index] = items
        }

    }
    print(result.count)
}

