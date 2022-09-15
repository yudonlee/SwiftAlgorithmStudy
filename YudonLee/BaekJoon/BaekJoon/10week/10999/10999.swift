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
    var lazy: [CLongLong]
    
    init(_ N: Int) {
        size = 1
        while(size <= N) {
            size *= 2
        }
        tree = Array(repeating: 0, count: size * 2)
        lazy = Array(repeating: 0, count: size * 2)
    }
    func update(pos: Int, value newValue: CLongLong) {
        var index = pos + size - 1
        let diff = newValue - tree[index]
        
        while(index > 0) {
            tree[index] += diff
            index /= 2
        }
    }
    
    func updateRange(start: Int, end: Int, node: Int, left: Int, right: Int, diff: CLongLong) {
        if lazy[node] != 0 {
            tree[node] += CLongLong(end - start + 1) * lazy[node]
            
            if (start != end) {
                lazy[node * 2] += lazy[node]
                lazy[node * 2 + 1] += lazy[node]
            }
            
            lazy[node] = 0
        }
        
        if right < start || end < left {
            return
        }
        
        if left <= start && end <= right {
            tree[node] += CLongLong(end - start + 1) * diff
            if start != end {
                lazy[node * 2] += diff
                lazy[node * 2 + 1] += diff
            }
            return
        }
        
        let mid = Int((start + end) / 2)
        updateRange(start: start, end: mid, node: node * 2, left: left, right: right, diff: diff)
        updateRange(start: mid + 1, end: end, node: node * 2 + 1, left: left, right: right, diff: diff)
        
        tree[node] = tree[node * 2] + tree[node * 2 + 1]
    }
    func sum(pos: Int, left: Int, right: Int, start: Int, end: Int) -> CLongLong {
        if lazy[pos] != 0 {
            tree[pos] += CLongLong(end - start + 1) * lazy[pos]
            
            if (start != end) {
                lazy[pos * 2] += lazy[pos]
                lazy[pos * 2 + 1] += lazy[pos]
            }
            
            lazy[pos] = 0
        }
        
        if(left > end || right < start) {
            return 0
        }
        if(start >= left && end <= right) {
            return tree[pos]
        }
        let mid = Int((start + end) / 2)
        return sum(pos: pos * 2, left: left, right: right, start: start, end: mid) + sum(pos: pos * 2 + 1, left: left, right: right, start: mid + 1, end: end)
    }
}



let fio = FileIO()
let N = fio.readInt()
let M = fio.readInt()
let K = fio.readInt()

let seg = SegTree(N)
for i in 1...N {
    seg.update(pos: i, value: CLongLong(fio.readInt()))
}

var t = M + K
while t > 0 {
    let command = fio.readInt()
    if command == 1 {
        let b = fio.readInt()
        let c = fio.readInt()
        
        let d = fio.readString()
        guard let d = CLongLong(d) else { fatalError()}
        seg.updateRange(start: 1, end: seg.size, node: 1, left: b, right: c, diff: CLongLong(d))
    } else if command == 2 {
        let b = fio.readInt()
        let c = fio.readInt()
        print(seg.sum(pos: 1, left: b, right: c, start: 1, end: seg.size))
    }
    
    t -= 1
}

