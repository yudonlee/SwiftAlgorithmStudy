//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/05/14.
//

import Foundation


//Swift에선 parameter를 포인터로 전달하는가? 참조를 어떤 방식으로 하는가
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

let FIO = FileIO()

var K = FIO.readInt()
var N = FIO.readInt()
var arr: [Int] = Array(repeating: 0, count: 10001)
var maxLength: Int = 0

for i in 0..<K {
    arr[i] = FIO.readInt()
    if(maxLength < arr[i]) {
        maxLength = arr[i]
    }
    
}

var left: Int = 1
var right: Int = maxLength


func countCable(arr: [Int], lanLength: Int) -> Int{
    var count: Int = 0
    for items in arr {
        count += Int(items / lanLength)
    }
    return count
}

while(left < right) {
    let mid: Int = (left + right) / 2
    if(countCable(arr: arr, lanLength: mid) < N) {
        right = mid
    } else {
        left = mid + 1
    }
//    print(left, right)
}

if(countCable(arr: arr, lanLength: left) < N) {
    left -= 1
}
print(left)


