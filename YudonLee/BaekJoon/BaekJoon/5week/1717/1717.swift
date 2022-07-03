//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/07/01.
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

let fio = FileIO()
let N = fio.readInt()
let M = fio.readInt()
var parent: [Int] = Array(repeating: 0, count: N + 1)

for i in 0...N {
    parent[i] = i
}

func find(node: Int) -> Int {
    if parent[node] == node {
        return node
    }
    parent[node] = find(node: parent[node])
    return parent[node]
}

func union(left: Int, right: Int) {
    let lParent = find(node: left)
    let rParent = find(node: right)
    parent[lParent] = rParent
}
for _ in 0..<M {
    let oper = fio.readInt()
    if oper == 0 {
        union(left: fio.readInt(), right: fio.readInt())
    } else {
        let leftParent = find(node: fio.readInt())
        let rightParent = find(node: fio.readInt())
        print(leftParent == rightParent ? "YES" : "NO")
    }
}
//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/07/03.
//

//import Foundation



//let firstInput = readLine()!.components(separatedBy: " ").map({ Int($0)! })
//let N = firstInput[0]
//let M = firstInput[1]
//
//var parent: [Int] = Array(repeating: 0, count: N + 1)
//
//func find(node: Int) -> Int {
//    if parent[node] != node {
//        parent[node] = find(node: parent[node])
//        return parent[node]
//    }
//
//    return node
//}
//
//func union(left: Int, right: Int) {
//    let leftParent = find(node: left)
//    let rightParent = find(node: right)
//
//    if leftParent < rightParent {
//        parent[rightParent] = leftParent
//    } else {
//        parent[leftParent] = rightParent
//    }
//}
//
//
//
//for index in 0...N {
//    parent[index] = index
//}
//
//for _ in 0..<M {
//    let oper = readLine()!.components(separatedBy: " ").map({ Int($0)! })
//    if oper[0] == 0 {
//        union(left: oper[1], right: oper[2])
//    } else {
//        if oper[1] == oper[2] {
//            print("YES")
//        } else {
//            let leftParent = find(node: oper[1])
//            let rightParent = find(node: oper[2])
//            print(leftParent == rightParent ? "YES" : "No")
//        }
//    }
//}
//
