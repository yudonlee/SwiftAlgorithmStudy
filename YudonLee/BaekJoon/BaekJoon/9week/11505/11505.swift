//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/07/20.
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
    private var tree: [Int64]
    private var size: Int = 1
    
    init(N: Int) {
        while(size < N) {
            size *= 2
        }
        tree = Array(repeating: 1, count: 2 * size)
    }
    
    func getSize() -> Int {
        return size
    }
    
    func update(pos: Int, x value: Int64) {
        var index = pos + size - 1
        var before = tree[index]
        
        if before == 0 {
            var parent = Int(index / 2)
            tree[index] = 1
            while(parent > 0) {
                let leaf = Int(parent * 2)
                tree[parent] = (tree[leaf] * tree[leaf + 1]) % 1000000007
                parent /= 2
            }
            before = 1
        }
        
        while(index > 0) {
            tree[index] /= before
//            tree[index] %= 1000000007
            tree[index] =  tree[index] * value % 1000000007
            index /= 2
        }
    }
    
    func getMultiply(pos: Int, left: Int, right: Int, start: Int, end: Int) -> Int64 {
        if left > end || right < start {
            return 1
        }
        if left <= start && right >= end {
            return tree[pos]
        }
        let mid = Int((start + end) / 2)
        return (getMultiply(pos: pos * 2, left: left, right: right, start: start, end: mid) * getMultiply(pos: pos * 2 + 1, left: left, right: right, start: mid + 1, end: end)) % 1000000007
    }
}



let fio = FileIO()
let N = fio.readInt()
let M = fio.readInt()
let K = fio.readInt()

let seg = SegTree(N: N)
for i in 1...N {
    seg.update(pos: i, x: Int64(fio.readInt()))
}

var t = M + K
while t > 0 {
    let a = fio.readInt()
    let b = fio.readInt()
    let c = fio.readInt()
    if a == 1 {
        seg.update(pos: b, x: Int64(c))
    } else {
        print(seg.getMultiply(pos: 1, left: b, right: c, start: 1, end: seg.getSize()))
    }
    t -= 1
}

