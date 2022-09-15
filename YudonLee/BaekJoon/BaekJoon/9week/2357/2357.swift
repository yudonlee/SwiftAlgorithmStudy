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

struct Pair {
    var max: CLongLong
    var min: CLongLong
    init() {
        max = Constants.MIN.rawValue
        min = Constants.MAX.rawValue
    }
}

enum Constants: CLongLong {
    case MAX = 123123123123
    case MIN = 0
}
class SegTree {
    private var tree: [Pair]
    private var size: Int
    
    init(N: Int) {
        size = 1
        while(size < N) {
            size *= 2
        }
        tree = Array(repeating: Pair(), count: size * 2)
    }

    func getSize() -> Int {
        return size
    }
    
    func update(pos: Int, value: CLongLong) {
        var index = pos + size - 1
        
        while(index > 0) {
            tree[index].min = min(tree[index].min, value)
            tree[index].max = max(tree[index].max, value)
            index /= 2
        }
    }
    
    func getMin(pos: Int, left: Int, right: Int, start: Int, end: Int) -> CLongLong{
        if left > end || right < start {
            return Constants.MAX.rawValue
        }
        if left <= start && right >= end {
            return tree[pos].min
        }
        let mid = Int((start + end) / 2)
        return min(getMin(pos: pos * 2, left: left, right: right, start: start, end: mid), getMin(pos: pos * 2 + 1, left: left, right: right, start: mid + 1, end: end))
    }
    
    func getMax(pos: Int, left: Int, right: Int, start: Int, end: Int) -> CLongLong{
        if left > end || right < start {
            return Constants.MIN.rawValue
        }
        if left <= start && right >= end {
            return tree[pos].max
        }
        let mid = Int((start + end) / 2)
        return max(getMax(pos: pos * 2, left: left, right: right, start: start, end: mid), getMax(pos: pos * 2 + 1, left: left, right: right, start: mid + 1, end: end))
    }
    
    
}
let fio = FileIO()

let N = fio.readInt()
let M = fio.readInt()
let segTree = SegTree(N: N)

for index in 1...N {
    segTree.update(pos: index, value: CLongLong(fio.readInt()))
}

for _ in 0..<M {
    let a = fio.readInt()
    let b = fio.readInt()
    let minimum = segTree.getMin(pos: 1, left: a, right: b, start: 1, end: segTree.getSize())
    let maximum = segTree.getMax(pos: 1, left: a, right: b, start: 1, end: segTree.getSize())
    print(minimum, maximum)
}

/*
 10 4
 75
 30
 100
 38
 50
 51
 52
 20
 81
 5
 1 10
 3 5
 6 9
 8 10
 */


/*
 8 4
 75
 30
 100
 38
 50
 51
 52
 20
 1 8
 3 5
 4 7
 6 8
 */
