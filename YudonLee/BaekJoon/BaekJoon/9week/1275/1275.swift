//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/07/19.
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

class SegmentTree {
    
    private var tree: [CLongLong]
    private var size: Int = 1
    init(N: Int) {
        while(size < N) {
            size *= 2
        }
        tree = Array(repeating: 0, count: size * 2)
    }
    
    func getSize() -> Int {
        return size
    }
    func update(pos: Int, value: CLongLong) {
        var index = pos + size - 1
        let differ = value - tree[index]
        
        while(index > 0) {
            tree[index] += differ
            index /= 2
        }
    }
    
    func getSum(pos: Int, left: Int, right: Int, start: Int, end: Int) -> CLongLong {
        if right < start || left > end {
            return 0
        }
        if left <= start && end <= right {
            return tree[pos]
        }
        let mid = Int((start + end) / 2)
        return getSum(pos: pos * 2 , left: left, right: right, start: start, end: mid) + getSum(pos: pos * 2 + 1, left: left, right: right, start: mid + 1, end: end)
    }
}

let fio = FileIO()
let N = fio.readInt()
let M = fio.readInt()

let segTree = SegmentTree(N: N)
for i in 1...N {
    segTree.update(pos: i, value: CLongLong(fio.readInt()))
}

for _ in 0..<M {
    var x = fio.readInt()
    var y = fio.readInt()
    
    if(x > y) {
        swap(&x, &y)
    }
    
    let a = fio.readInt()
    let b = fio.readInt()
    
    let result = segTree.getSum(pos: 1, left: x, right: y, start: 1, end: segTree.getSize())
    segTree.update(pos: a, value: CLongLong(b))
    print(result)
}





/*
 5 2
 1 2 3 4 5
 2 3 3 1
 3 5 4 1
 */
