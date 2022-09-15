//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/07/24.
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


class SegTree {
    
    var size: Int
    var tree: [CLongLong]
    var numbers: [CLongLong]
    init(n: Int) {
        size = 1
        while(size < n) {
            size *= 2
        }
        tree = Array(repeating: 0, count: size + 1)
        numbers = Array(repeating: 0, count: size + 1)
    }
    
    func update(pos: Int, x: CLongLong) {
        let diff = x - numbers[pos]
        numbers[pos] = x
        var index = pos
        while(index <= size) {
            tree[index] += diff
            index += (index & (-index))
        }
    }
    
    func sum(pos: Int) -> CLongLong {
        var result: CLongLong = 0
        var index = pos
        while(index > 0) {
            result += tree[index]
            index -= (index & (-index))
        }
        return result
    }
}
let fio = FileIO()
let N = fio.readInt()
let M = fio.readInt()
let K = fio.readInt()

let seg = SegTree(n: N)
for i in 1...N {
    seg.update(pos: i, x: CLongLong(fio.readInt()))
}

var t = M + K
while t > 0 {
    let a = fio.readInt()
    let b = fio.readInt()
    let c = fio.readInt()
    if a == 1 {
        seg.update(pos: b, x: CLongLong(c))
    } else {
        print(seg.sum(pos: c) - seg.sum(pos: b - 1))
    }
    t -= 1
}

