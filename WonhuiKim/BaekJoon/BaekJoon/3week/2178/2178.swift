//
//  2178.swift 미로탐색
//  BaekJoon
//
//  Created by 김원희 on 2022/05/21.
//

import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0] //줄 수 (행)
let M = NM[1] //칸 수 (열)

var arr: [[Int]] = Array(repeating: Array(repeating: -1, count: M+2), count: N+2)
var dist: [[Int]] = Array(repeating: Array(repeating: 0, count: M+1), count: N+1)
var visit: [[Bool]] = Array(repeating: Array(repeating: false, count: M+1), count: N+1)

let dx = [-1, 0, 1, 0]
let dy = [0, -1, 0, 1]

for i in 1..<N+1 {
    let input = Array(readLine()!).map { Int(String($0))! }
    for j in 1..<M+1 {
        arr[i][j] = input[j-1]
    }
}

bfs(x: 1,y: 1)
print(dist[N][M])

func bfs(x: Int, y: Int) {
    var queue = [(Int, Int)]()
    
    queue.append((x, y))
    visit[x][y] = true
    dist[x][y] = 1
    
    while(!queue.isEmpty) {
        let temp = queue.removeFirst()

        
        for i in 0..<4 {
            let nextX = temp.0 + dx[i]
            let nextY = temp.1 + dy[i]

            if arr[nextX][nextY] == 1 && !visit[nextX][nextY]{
                queue.append((nextX, nextY))
                visit[nextX][nextY] = true
                dist[nextX][nextY] = dist[temp.0][temp.1] + 1
            }
        }
    }
}

