//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/05/19.
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
struct Queue {
    var front: Int = 0
    var rear: Int = -1
    var arr: [Int] = Array(repeating: 0, count: 10001)
    
    mutating func push(element: Int) {
        if(isFull()) {
            return
        }
        rear += 1
        self.arr[rear] = element
    }
    func top() -> Int {
        if(isEmpty()) {
            return -1
        }
        return arr[front]
    }
    func isEmpty() -> Bool {
        if(front > rear) {
            return true
        }
        return false
    }
    func isFull() -> Bool {
        if(rear != 10000) {
            return false
        }
        return true
    }
    mutating func pop() {
        if(front <= rear) {
            front += 1
        }
    }
    
}

struct Stack {
    var tail: Int = -1
    var arr: [Int] = Array(repeating: 0, count: 10001)
    
    mutating func push(element: Int) {
        tail += 1
        arr[tail] = element
    }
    
    
    
    func isEmpty() -> Bool {
        if(tail == -1) {
            return true
        }
        return false
    }
    
    func top() -> Int {
        if(isEmpty()) {
            return -1
        }
        return arr[tail]
    }
    
    func isFull() -> Bool {
        if(tail != 10000) {
            return false
        }
        return true
    }
    mutating func pop() {
        if(isEmpty()) {
            return
        }
        arr[tail] = 0
        tail -= 1
    }
    
}




let FIO = FileIO()

let N: Int = FIO.readInt()
let M: Int = FIO.readInt()
let start: Int = FIO.readInt()
var arr: [[Int]] = Array(repeating: [], count: 1001)

var s: Stack = Stack()
var q: Queue = Queue()

s.push(element: start)
q.push(element: start)

for _ in 0..<M {
    let src: Int = FIO.readInt()
    let dest: Int = FIO.readInt()
    arr[src].append(dest)
    arr[dest].append(src)
}


var visitNode: [Bool] = Array(repeating: false, count: 1001)

while(!s.isEmpty()) {
    let top: Int = s.top()
    s.pop()
    if(!visitNode[top]) {
        visitNode[top] = true
        print(top, terminator: " ")
        arr[top].sort()
        for nextNode in arr[top].reversed() {
            if(!visitNode[nextNode]) {
                s.push(element: nextNode)
            }
        }
    }
}

print()

var visitNodeTwo: [Bool] = Array(repeating: false, count: 1001)
while(!q.isEmpty()) {
    let top: Int = q.top()
    q.pop()
    if(!visitNodeTwo[top]) {
        visitNodeTwo[top] = true
        print(top, terminator: " ")
        arr[top].sort()
        for nextNode in arr[top] {
            if(!visitNodeTwo[nextNode]) {
                q.push(element: nextNode)
            }
        }
    }
}




