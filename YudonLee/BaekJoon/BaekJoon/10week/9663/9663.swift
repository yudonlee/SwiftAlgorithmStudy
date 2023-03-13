//
//  9663.swift N-Queen (backtracking)
//  BaekJoon
//
//  Created by 김원희 on 2022/07/22.
//

import Foundation
//
//final class FileIO {
//    private let buffer: Data
//    private var index: Int = 0
//
//    init(fileHandle: FileHandle = FileHandle.standardInput) {
//        self.buffer = try! fileHandle.readToEnd()! // 인덱스 범위 넘어가는 것 방지
//    }
//
//    @inline(__always) private func read() -> UInt8 {
//        defer {
//            index += 1
//        }
//        guard index < buffer.count else { return 0 }
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
//
//    @inline(__always) func readString() -> String {
//        var str = ""
//        var now = read()
//
//        while now == 10
//                || now == 32 { now = read() } // 공백과 줄바꿈 무시
//
//        while now != 10
//                && now != 32 && now != 0 {
//            str += String(bytes: [now], encoding: .ascii)!
//            now = read()
//        }
//
//        return str
//    }
//}
//
//let FIO = FileIO()
//let N = FIO.readInt() //체스판 크기
//
//var board: [Int] = Array(repeating: -1, count: N)
//
//var cnt = 0
//bt(depth: 0)
//print(cnt)
//
//func bt(depth: Int) {
//    if depth == N {
//        cnt += 1
//        return
//    }
//
//    for i in 0..<N {
//        board[depth] = i
//        if isPossible(col: depth) {
//            bt(depth: depth+1)
//        }
//    }
//}
//
//
//func isPossible(col: Int) -> Bool {
//    for i in 0..<col {
//        if board[col] == board[i] {
//            return false
//        } else if (col-board[col]) == (i-board[i]) {
//            return false
//        } else if (col+board[col] == (i+board[i])) {
//            return false
//        }
//    }
//
//    return true
//}
//


//let numbers = [7, 77, 777, 7777]
//
//numbers.forEach { item in
//    print(String(format: "%04d", item))
//}

let str: [String] = ["test"]
var test: [String]?
test = str
print(test)

//output
//0007
//0077
//0777
//7777
