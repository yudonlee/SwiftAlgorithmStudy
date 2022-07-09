//
//  1865.swift 웜홀(Bellman-Ford)
//  BaekJoon
//
//  Created by 김원희 on 2022/07/03.
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

let TC = FIO.readInt() //test case

for _ in 0..<TC {
    let N = FIO.readInt() //지점(정점 수)
    let M = FIO.readInt() //도로(간선 수)
    let W = FIO.readInt() //웜홀(음수 간선 수)
    
    var edges = [Edge]()
    let maxDist = 10001 * (N-1)
    var dist: [Int] = Array(repeating: maxDist, count: N+1)
    
    for _ in 0..<M { //간선
        let S = FIO.readInt() //시작 지점
        let E = FIO.readInt() //도착 지점
        let T = FIO.readInt() //소요 시간
        
        edges.append(Edge(src: S, dest: E, weight: T))
        edges.append(Edge(src: E, dest: S, weight: T)) //양방향이므로 S,E 바꿔서 2번
    }
    
    for _ in 0..<W { //음수 간선
        let S = FIO.readInt()
        let E = FIO.readInt()
        let T = FIO.readInt() * -1
        
        edges.append(Edge(src: S, dest: E, weight: T)) //단방향
    }
    
    var flag = false
    var visit: [Bool] = Array(repeating: false, count: N+1)
    for i in edges { //모든 정점(시간 초과) -> 시작 정점이 될 수 있는 경우만!
        if !visit[i.src] {
            visit[i.src] = true //중복 않기 위해 visit 체크
            
            if bellmanFord(start: i.src) {
                flag = true
                break
            }
        }
    }
    
    !flag ? print("NO") : print("YES")
    
    func bellmanFord(start: Int) -> Bool {
        dist[start] = 0
        
        for i in 0..<N {
            for edge in edges {
                if dist[edge.src] != maxDist {
                    if dist[edge.dest] > dist[edge.src] + edge.weight {
                        dist[edge.dest] = dist[edge.src] + edge.weight
                        
                        if i == N-1 {
                            return true //음수 사이클 존재
                        }
                    }
                }
            }
        }
        
        return false
    }
}

struct Edge {
    var src: Int
    var dest: Int
    var weight: Int
}
