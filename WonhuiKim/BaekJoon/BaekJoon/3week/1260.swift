//
// 1260.swift
//  BaekJoon
//
//  Created by 김원희 on 2022/05/20.
//

/*
 그래프를 DFS로 탐색한 결과와 BFS로 탐색한 결과를 출력하는 프로그램을 작성하시오. 단, 방문할 수 있는 정점이 여러 개인 경우에는 정점 번호가 작은 것을 먼저 방문하고, 더 이상 방문할 수 있는 점이 없는 경우 종료한다. 정점 번호는 1번부터 N번까지이다.
 
 첫째 줄에 정점의 개수 N(1 ≤ N ≤ 1,000), 간선의 개수 M(1 ≤ M ≤ 10,000), 탐색을 시작할 정점의 번호 V가 주어진다. 다음 M개의 줄에는 간선이 연결하는 두 정점의 번호가 주어진다. 어떤 두 정점 사이에 여러 개의 간선이 있을 수 있다. 입력으로 주어지는 간선은 양방향이다.
 */

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

let N = FIO.readInt() //정점 개수
let M = FIO.readInt() //간선 개수
let V = FIO.readInt() //탐색 시작 정점

var arr : [[Int]] = Array(repeating: Array(repeating: 0, count: N+1), count: N+1)
var visit_dfs : [Bool] = Array(repeating: false, count: N+1)
var visit_bfs : [Bool] = Array(repeating: false, count: N+1)

for _ in 0..<M {
    let first = FIO.readInt()
    let second = FIO.readInt()
    
    arr[first][second] = 1;
    arr[second][first] = 1;
}

//dfs_recursion(edge: V)
dfs(edge: V)
print()
bfs(edge: V)


func dfs_recursion(edge: Int) -> Void {
    visit_dfs[edge] = true
    print(edge, terminator: " ")
    for item in 1...N {
        if !visit_dfs[item] && arr[edge][item] == 1 {
            dfs_recursion(edge: item)
        }
    }
}

struct Stack<T> {
    private var stack = [T]()
    
    public var count: Int {
        return stack.count
    }
    
    public var isEmpty: Bool {
        return stack.isEmpty
    }
    
    public mutating func push(_ element: T) {
        stack.append(element)
    }
    
    public mutating func pop() -> T? {
        return isEmpty ? nil : stack.popLast()
    }
}

struct Queue<T> {
    private var queue = [T]()
    
    public var count: Int {
        return queue.count
    }
    
    public var isEmpty: Bool {
        return queue.isEmpty
    }
    
    public mutating func add(_ element: T) {
        queue.append(element)
    }
    
    public mutating func offer() -> T? {
        return isEmpty ? nil : queue.removeFirst()
    }
}

func dfs(edge: Int) {
    var stack = Stack<Int>()
    
    stack.push(edge)
    
    while(!stack.isEmpty) {
        let temp = stack.pop()
        
        if !visit_dfs[temp!] {
            visit_dfs[temp!] = true
            print(temp!, terminator: " ")
            
            for i in (1...N).reversed() {
                if !visit_dfs[i] && arr[temp!][i] == 1 {
                    stack.push(i)
                }
            }
        }
    }
}

func bfs(edge: Int) {
    var queue = Queue<Int>()
    
    queue.add(edge)
    visit_bfs[edge] = true
    
    while(!queue.isEmpty) {
        let temp = queue.offer()
        
        print(temp!, terminator: " ")
        
        for i in 1...N {
            if !visit_bfs[i] && arr[temp!][i] == 1 {
                queue.add(i)
                visit_bfs[i] = true
            }
        }
    }
}




