//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/05/24.
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
    var arr: [T] = []

    mutating func push(element: T) {
        arr.append(element)
    }
    func isEmpty()-> Bool {
        return arr.isEmpty
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
struct Grid {
    var row: Int
    var col: Int
}

let fio = FileIO()
let N = fio.readInt()
let M = fio.readInt()
let K = fio.readInt()

let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]

var matrix = Array(repeating: Array(repeating: 0, count: M), count: N)

for _ in 0..<K {
    let leftCol = fio.readInt()
    let leftRow = fio.readInt()
    let rightCol = fio.readInt()
    let rightRow = fio.readInt()

    for i in leftRow..<rightRow {
        for j in leftCol..<rightCol {
            matrix[i][j] = 1
        }
    }
}

var result: [Int] = []
for i in 0..<N {
    for j in 0..<M {
        if(matrix[i][j] == 0) {
            var s = Stack<Grid>()
            var count: Int = 0
            s.push(element: Grid(row: i, col: j))
            while(!s.isEmpty()) {
                if let t = s.top() {
                    s.pop()
                    if matrix[t.row][t.col] == 0 {
                        count += 1
                        matrix[t.row][t.col] = 1

                        for k in 0...3 {
                            var nextRow: Int = t.row + dy[k]
                            var nextCol: Int = t.col + dx[k]
                            if 0 <= nextRow && nextRow < N && 0 <= nextCol && nextCol < M {
                                if matrix[nextRow][nextCol] == 0 {
                                    s.push(element: Grid(row: nextRow, col: nextCol))
                                }
                            }
                        }
                    }
                }
            }

            if count != 0 {
                result.append(count)
            }
        }
    }
}
print(result.count)
result.sort()
result.forEach({ x in print(x, terminator: " ")})

