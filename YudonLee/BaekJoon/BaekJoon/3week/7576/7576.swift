////
////  Main.swift
////  BaekJoon
////
////  Created by yudonlee on 2022/05/24.
////
//
//import Foundation
//
//final class FileIO {
//    private let buffer:[UInt8]
//    private var index: Int = 0
//
//    init(fileHandle: FileHandle = FileHandle.standardInput) {
//
//        buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
//    }
//
//    @inline(__always) private func read() -> UInt8 {
//        defer { index += 1 }
//
//        return buffer[index]
//    }
//
//    @inline(__always) func readInt() -> Int {
//        var sum = 0
//        var now = read()
//        var isPositive = true
//
//        while now == 10
//                || now == 32 { now = read() } // 공백과 줄바꿈 무시
//        if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
//        while now >= 48, now <= 57 {
//            sum = sum * 10 + Int(now-48)
//            now = read()
//        }
//
//        return sum * (isPositive ? 1:-1)
//    }
//
//    @inline(__always) func readString() -> String {
//        var now = read()
//
//        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
//        let beginIndex = index-1
//
//        while now != 10,
//              now != 32,
//              now != 0 { now = read() }
//
//        return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
//    }
//
//    @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
//        var now = read()
//
//        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
//        let beginIndex = index-1
//
//        while now != 10,
//              now != 32,
//              now != 0 { now = read() }
//
//        return Array(buffer[beginIndex..<(index-1)])
//    }
//}
//
//
//struct Queue<T> {
//    var arr: [T] = []
//    var front: Int = 0
//    var rear: Int = -1
//    func isEmpty() -> Bool {
//        if(front <= rear) {
//            return false
//        }
//        return true
//    }
//
//    mutating func push(element: T) {
//        arr.append(element)
//        rear += 1
//    }
//
//    func top() -> T? {
//        if(!isEmpty()) {
//            return arr[front]
//        }
//        return nil
//    }
//
//    mutating func pop() {
//        if(!isEmpty()) {
//            front += 1
//        }
//    }
//
//}
//
//struct Grid {
//    var row: Int
//    var col: Int
//    var day: Int
//}
//
//let FIO = FileIO()
//
//let M = FIO.readInt()
//let N = FIO.readInt()
//
//let dy = [-1, 1, 0, 0]
//let dx = [0, 0, -1, 1]
//
//var matrix: [[Int]] = []
//
//var tomatoCount: Int = 0
//
//var queue = Queue<Grid>()
//
//var visitNode: [[Bool]] = Array(repeating: Array(repeating: false, count: M), count: N)
//
//var ans: Int = -1
//
//for i in 0..<N {
//    var line: [Int] = []
//
//    for j in 0..<M {
//        let element = FIO.readInt()
//        line.append(element)
//        if line[j] == 0 {
//            tomatoCount += 1
//        } else if line[j] == 1 {
//            queue.push(element: Grid(row: i, col: j, day: 0))
//        } else {
//            visitNode[i][j] = true
//        }
//    }
//    matrix.append(line)
//}
//
//if tomatoCount == 0 {
//    print(0)
//} else {
//    while(!queue.isEmpty() && tomatoCount > 0) {
//        if let top = queue.top() {
//            queue.pop()
//            if !visitNode[top.row][top.col] {
//                visitNode[top.row][top.col] = true
//
//                if(matrix[top.row][top.col] == 0) {
//                    matrix[top.row][top.col] = 1
//                    tomatoCount -= 1
//                    if(tomatoCount == 0) {
//                        ans = top.day
//                        break;
//                    }
//                }
//
//                for i in 0...3 {
//                    let nextRow: Int = top.row + dy[i]
//                    let nextCol: Int = top.col + dx[i]
//
//                    if(0 <= nextRow && nextRow < N && 0 <= nextCol && nextCol < M) {
//                        if !visitNode[nextRow][nextCol] && matrix[nextRow][nextCol] == 0{
//                            queue.push(element: Grid(row: nextRow, col: nextCol, day: top.day + 1))
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//    print(ans)
//}


