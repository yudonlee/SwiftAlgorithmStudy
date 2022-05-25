//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/05/20.
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

struct Stack<T> {
//    빈 array 선언
    var arr: [T] = []
    
    func isEmpty() -> Bool {
        if(arr.count != 0) {
            return false
        }
        return true
    }
    mutating func push(element: T) {
        arr.append(element)
    }
    func top() -> T? {
        if(!isEmpty()) {
            return arr.last
        }
        return nil
    }
    mutating func pop() {
        if(!isEmpty()) {
            arr.removeLast()
        }
    }
}

let FIO: FileIO = FileIO()
let N: Int = FIO.readInt()
let M: Int = FIO.readInt()

var adj: [[Int]] = Array(repeating: [], count: 1001)

for _ in 0..<M {
    let src: Int = FIO.readInt()
    let dest: Int = FIO.readInt()
    adj[src].append(dest)
    adj[dest].append(src)
}

var visitNode: [Bool] = Array(repeating: false, count: 1001)
var count: Int = 0

for start in 1...N {
    var s = Stack<Int>()
    if(!visitNode[start]) {
        count += 1
        s.push(element: start)
    }
    while(!s.isEmpty()) {
        let top: Int = s.top() ?? -1
        s.pop()
        visitNode[top] = true
        for next in adj[top] {
            if(!visitNode[next]) {
                s.push(element: next)
            }
        }
    }
}

print(count)


