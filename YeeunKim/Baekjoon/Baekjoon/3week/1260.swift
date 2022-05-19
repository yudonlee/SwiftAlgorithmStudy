//  [BOJ] 1260 - DFS와 BFS
//  2022/05/18

let cmd = readLine()!.split(separator: " ").map{Int($0)!}
var graph: [[Int]] = Array(repeating: Array(repeating: 0, count: 0), count: cmd[0] + 1)

for _ in 0..<cmd[1] {
    let link = readLine()!.split(separator: " ").map{Int($0)!}
    graph[link[0]].append(link[1])
    graph[link[1]].append(link[0])
}

func dfs(start: Int) {
    var visited: [Int] = []
    var stack = [start]
    
    while !stack.isEmpty {
        let node = stack.popLast()!
        // popLast 옵셔널이라 !를 해줘야함 (옵셔널 없애기)
        
        if !visited.contains(node) {
            visited.append(node)
            print(node, terminator: " ")
            stack.append(contentsOf: graph[node].sorted(by: >))
        }
    }
}

func bfs(start: Int) {
    var visited: [Int] = []
    var queue = [start]
    
    while !queue.isEmpty {
        let node = queue.removeFirst()
        // pop은 first가 없다, 옵셔널이 아니라 !가 필요없음, must not be empty, 빈값일 경우 에러!
        
        if !visited.contains(node) {
            visited.append(node)
            print(node, terminator: " ")
            queue.append(contentsOf: graph[node].sorted())
        }
    }
}
dfs(start: cmd[2])
print()
bfs(start: cmd[2])
