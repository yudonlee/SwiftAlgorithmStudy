//
//  1976.swift 여행가자 disjoint set
//  BaekJoon
//
//  Created by 김원희 on 2022/07/05.
//

import Foundation

final class FileIO {
    private let buffer: Data
    private var index: Int = 0
    
    init(fileHandle: FileHandle = FileHandle.standardInput) {
        self.buffer = try! fileHandle.readToEnd()! // 인덱스 범위 넘어가는 것 방지
    }
    
    @inline(__always) private func read() -> UInt8 {
        defer {
            index += 1
        }
        guard index < buffer.count else { return 0 }
        
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
        var str = ""
        var now = read()
        
        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        
        while now != 10
                && now != 32 && now != 0 {
            str += String(bytes: [now], encoding: .ascii)!
            now = read()
        }
        
        return str
    }
}

let FIO = FileIO()
let N = FIO.readInt() //도시의 수 1...N
let M = FIO.readInt() //여행 계획 도시 (FIND 반복 수)

var parent = [Int]()
for i in 0...N {
    parent.append(i) //각 노드의 부모 노드를 본인으로 초기화
}

for i in 1...N {
    for j in 1...N {
        let link = FIO.readInt()
        if link == 1 {
            UNION(a: i, b: j)
        }
    }
}

var flag = true
var root = FIND(node: FIO.readInt())
for _ in 1..<M {
    if root != FIND(node: FIO.readInt()) {
        flag = false
        break
    }
}
flag == true ? print("YES") : print("NO")


func FIND(node: Int) -> Int {
    if node == parent[node] {
        return node
    }
    
    parent[node] = FIND(node: parent[node])
    return parent[node]
}

func UNION(a: Int, b: Int) {
    //각 노드의 루트 노드 찾기
    let root_a = FIND(node: a)
    let root_b = FIND(node: b)
    
    parent[root_b] = root_a //루트 노드를 같게 해줌 -> 같은 트리
}
