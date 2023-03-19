////
////  main.swift
////  BaekJoon
////
////  Created by yudonlee on 2023/03/18.
////
//
////1941
////총 25명의 여학생들로 이루어진 여학생반은 5×5의 정사각형 격자 형태로 자리가 배치되었고, 얼마 지나지 않아 이다솜과 임도연이라는 두 학생이 두각을 나타내며 다른 학생들을 휘어잡기 시작했다. 곧 모든 여학생이 ‘이다솜파’와 ‘임도연파’의 두 파로 갈라지게 되었으며, 얼마 지나지 않아 ‘임도연파’가 세력을 확장시키며 ‘이다솜파’를 위협하기 시작했다.
////
////위기의식을 느낀 ‘이다솜파’의 학생들은 과감히 현재의 체제를 포기하고, ‘소문난 칠공주’를 결성하는 것이 유일한 생존 수단임을 깨달았다. ‘소문난 칠공주’는 다음과 같은 규칙을 만족해야 한다.
////
////이름이 이름인 만큼, 7명의 여학생들로 구성되어야 한다.
////강한 결속력을 위해, 7명의 자리는 서로 가로나 세로로 반드시 인접해 있어야 한다.
////화합과 번영을 위해, 반드시 ‘이다솜파’의 학생들로만 구성될 필요는 없다.
////그러나 생존을 위해, ‘이다솜파’가 반드시 우위를 점해야 한다. 따라서 7명의 학생 중 ‘이다솜파’의 학생이 적어도 4명 이상은 반드시 포함되어 있어야 한다.
////여학생반의 자리 배치도가 주어졌을 때, ‘소문난 칠공주’를 결성할 수 있는 모든 경우의 수를 구하는 프로그램을 작성하시오.
//import Foundation
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
//
////var board = Array(repeating: Array(repeating: "Y", count: 5), count: 5)
////let dy = [0, 0, 1, -1]
////let dx = [1, -1, 0, 0]
////
////var result = 0
////
////func dfs(_ visited: [[Bool]], _ members: [String], _ row: Int, _ col: Int, yMemberCount: Int) {
////    if visited[row][col] {
////        return
////    }
////
////    let member = board[row][col]
////    var visited = visited
////    visited[row][col] = true
////    var appendedMember = members
////    appendedMember.append(member)
////    var yMemberCount = yMemberCount
////    yMemberCount += member == "Y" ? 1 : 0
////
////    if yMemberCount > 3 {
////        return
////    }
////
////    if appendedMember.count == 7 {
////        result += 1
////        return
////    }
////
////    for idx in 0...3 {
////        let nextRow = row + dy[idx]
////        let nextCol = col + dx[idx]
////        if 0 <= nextRow, nextRow < 5, 0 <= nextCol, nextCol < 5 {
////            dfs(visited, appendedMember, nextRow, nextCol, yMemberCount: yMemberCount)
////        }
////    }
////
////
////}
////
////for row in 0...4 {
////    for col in 0...4 {
////        board[row][col] = FIO.readString()
////    }
////}
////
////let visited = Array(repeating: Array(repeating: false, count: 5), count: 5)
////
////for row in 0...4 {
////    for col in 0...4 {
////        board[row][col] = FIO.readString()
////    }
////}
////dfs(visited, [], 0, 0, yMemberCount: <#T##Int#>)
//
//
//struct Stack<T> {
//    var arr: [T] = []
//    func isEmpty() -> Bool {
//        return arr.isEmpty
//    }
//    
//    mutating func push(element: T) {
//        arr.append(element)
//    }
//    
//    mutating func pop() -> T {
//        return arr.removeLast()
//    }
//}
////struct Queue<T> {
////    var arr:[T] = []
////    var front: Int = 0
////    var rear: Int = -1
////
////    func isEmpty() -> Bool {
////        if(front <= rear) {
////            return false
////        }
////        return true
////    }
////    mutating func push(element: T) {
////        arr.append(element)
////        rear += 1
////    }
////    func top() -> T? {
////        if(!isEmpty()) {
////            return arr[front]
////        }
////        return nil
////    }
////    mutating func pop() {
////        if(!isEmpty()) {
////            front += 1
////        }
////    }
////}
//
//
//
//func combinations() -> [[(Int, Int)]]{
//    var allList: [(Int, Int)] = []
//    var result: [[(Int, Int)]] = []
//    for row in 0...4 {
//        for col in 0...4 {
//            allList.append((row, col))
//        }
//    }
//    var stack = Stack<(idx: Int, cases: [(Int, Int)])>()
//    
//    stack.push(element: (idx: 0, cases: []))
//    
//    while !stack.isEmpty() {
//        let top = stack.pop()
//        if (25 - top.idx + top.cases.count) < 7 {
//            continue
//        }
//        
//        if top.cases.count == 7 {
//            result.append(top.cases)
//            continue
//        }
//        stack.push(element: (idx: top.idx + 1, cases: top.cases))
//        stack.push(element: (idx: top.idx + 1, cases: top.cases + [allList[top.idx]]))
//    }
//    
//    return result
//}
//
//var board = Array(repeating: Array(repeating: "Y", count: 5), count: 5)
//
//for row in 0...4 {
//    for col in 0...4 {
//        board[row][col] = FIO.readString()
//    }
//}
//var allCases = combinations()
//var dy = [0, 0, 1, -1]
//var dx = [1, -1, 0, 0]
//var count = 0
//allCases.forEach {
//    var visited = Array(repeating: Array(repeating: -1, count: 5), count: 5)
//    var yMemberCount = 0
//    $0.forEach {
//        visited[$0.0][$0.1] = 0
//        yMemberCount += board[$0.0][$0.1] == "Y" ? 1 : 0
//    }
//    if yMemberCount > 3 {
//        return
//    }
//    
//    var resultStatus = true
//    for item in $0 {
//        var status = false
//        for idx in 0...3 {
//            let nextRow = item.0 + dy[idx]
//            let nextCol = item.1 + dx[idx]
//            if 0 <= nextRow, nextRow < 5, 0 <= nextCol, nextCol < 5 {
//                if visited[nextRow][nextCol] == 0 {
//                    status = true
//                }
//            }
//        }
//        
//        if !status {
//            resultStatus = false
//            break
//        }
//    }
//    
//    if resultStatus {
//        count += 1
//    }
//}
//
//print(count)
