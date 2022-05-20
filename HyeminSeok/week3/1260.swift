

// 1260번 DFS, BFS

import Foundation

let input = readLine()!.split(separator: " ").map{Int($0)!}
let n = input[0] // 노드의 개수
let m = input[1] // 간선의 개수
let x = input[2] // 시작하는 노드의 숫자

var graph: [[Int]] = Array(repeating: Array(repeating: 0, count: 0), count: n + 1)
// 시작노드 및 도착노드를 받기 위한 이차원 배열

func dfs(_ start: Int) {
    var visit:[Int] = [] // visit 배열 생성
    var stack = [start] //dfs이므로 스택이용
    
    while !stack.isEmpty {
        let node = stack.popLast()!
        
        if !visit.contains(node) {
            visit.append(node)
            print(node, terminator: " ")
            stack.append(contentsOf: graph[node].sorted(by:>))
                // 내림차순 정렬

        }
    }
}

func bfs(_ start: Int) {
    var visit:[Int] = []
    var queue = [start] // bfs이므로 큐 이용
    
    while !queue.isEmpty {
        let node = queue.removeFirst()
        
        if !visit.contains(node) {
            visit.append(node)
            print(node, terminator: " ")
            queue.append(contentsOf: graph[node].sorted())
            // 오름차순 정렬
        }
    }
}

// 노드 값들을 입력받는다
for _ in 0..<m {
    let nodes = readLine()!.split(separator: " ").map{Int($0)!}
    let start = nodes[0] // 시작노드
    let end = nodes[1] // 도착노드
    graph[start].append(end)
    graph[end].append(start)
    // 서로 연결되어 있는 값들을 추가한다
}

dfs(x)
print()
bfs(x)
