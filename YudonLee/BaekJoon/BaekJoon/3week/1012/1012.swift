//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/05/23.
//

import Foundation

struct Stack<T> {
    var arr: [T] = []
    
    func isEmpty() -> Bool {
        if(arr.count != 0) {
            return false;
        }
        return true
    }
    
    mutating func push(element: T) {
        arr.append(element)
    }
    func top() -> T? {
        if(!isEmpty()) {
            return arr.first
        }
        return nil;
    }
    mutating func pop() {
        if(!isEmpty()) {
            arr.removeFirst()
        }
    }
}

struct grid {
    var row: Int
    var col: Int
}
let number: Int = Int(readLine()!)!

let dy: [Int] = [0, 0, -1, 1]
let dx: [Int] = [-1, 1, 0, 0]

for _ in 0..<number {
    let inputs: [Int] = readLine()!.components(separatedBy: " ").map({ Int($0)!})
    let M: Int = inputs[0]
    let N: Int = inputs[1]
    let K: Int = inputs[2]
    
    var edges: [(Int, Int)] = []
    var visitNode: [[Bool]] = Array(repeating: Array(repeating: false, count: M), count: N)
    var matrix: [[Int]] = Array(repeating: Array(repeating: 0, count: M), count: N)
    
    for _ in 0..<K {
        let edge: [Int] = readLine()!.components(separatedBy: " ").map({ Int($0)! })
        edges.append((edge[0], edge[1]))
        matrix[edge[1]][edge[0]] = 1
        
    }
    
    var count: Int = 0
    
    for items in edges {
        
        if(!visitNode[items.1][items.0]) {
            count += 1
            var s = Stack<grid>()
            s.push(element: grid(row: items.1, col: items.0))
            
            while(!s.isEmpty()) {
                if let t = s.top() {
                    s.pop()
                    
                    if !visitNode[t.row][t.col] && matrix[t.row][t.col] == 1 {
                        visitNode[t.row][t.col] = true
                        
                        for i in 0..<4 {
                            let nextRow: Int = t.row + dy[i]
                            let nextCol: Int = t.col + dx[i]
                            if 0 <= nextRow && nextRow < N && 0 <= nextCol && nextCol < M {
                                s.push(element: grid(row: nextRow, col: nextCol))
                            }
                        }
                    }
                }
                
            }
            
        }
    }
    
    print(count)
}
