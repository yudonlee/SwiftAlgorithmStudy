//
//  File.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/07/18.
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
    var tree: [CLongLong]
    var size: Int
    init(n: Int) {
        size = 1
        while(size < n) {
            size *= 2
        }
        tree = Array(repeating: 0, count: size * 2)
    }
    
    func update(pos: Int, x: CLongLong) {
        var index = size + pos - 1
        var diff = x - tree[index]
        while(index > 0) {
            tree[index] += diff
            index /= 2
        }
    }
    
    func getSum(pos: Int, left: Int, right: Int, start: Int, end: Int) -> CLongLong {
        if right < start || left > end {
            return 0
        }
        
        if start >= left && end <= right {
            return tree[pos]
        }
        
        let mid = (start + end) / 2
        return getSum(pos: pos * 2, left: left, right: right, start: start, end: mid) + getSum(pos: pos * 2 + 1, left: left, right: right, start: mid + 1, end: end)
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
        print(seg.getSum(pos: 1, left: b, right: c, start: 1, end: seg.size))
    }
    t -= 1
}
