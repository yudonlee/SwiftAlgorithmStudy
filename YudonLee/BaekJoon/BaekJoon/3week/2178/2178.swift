//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/05/20.
//

import Foundation

struct Stack<T>{
    var arr: [T] = []

    func isEmpty() -> Bool {
        if(arr.count != 0) {
            return false
        }
        return true
    }
    mutating func push(element: T) {
        arr.append(element)
    }
    func top() -> T? {
        if(!isEmpty()) {
            return arr.last
        }
        return nil
    }
    mutating func pop() {
        if(!isEmpty()) {
            arr.removeLast()
        }
    }
}

struct grid {
    var row: Int
    var col: Int
    var length: Int
    
}

struct Queue<T> {
    var arr: [T] = []
    
    mutating func push(element: T) {
        self.arr.append(element)
    }
    func isEmpty() -> Bool{
        if(arr.count != 0) {
            return false
        }
        return true
    }
    func top() -> T? {
        if(!isEmpty()) {
            return arr.first
        }
        return nil
    }
    mutating func pop() {
        if(!isEmpty()) {
            arr.removeFirst()
        }
    }
}
let line = readLine()!.components(separatedBy: " ").map({ Int($0)!})
let N: Int = line[0]
let M: Int = line[1]

let dy: [Int] = [1, -1, 0, 0]
let dx: [Int] = [0, 0, 1, -1]
var matrix: [[Int]] = []

var visitNode: [[Bool]] = Array(repeating: Array(repeating: false, count: M), count: N)
for row in 0..<N {
    let line = readLine()!.map({ Int(String($0))! })
    matrix.append(line)
}

var q = Queue<grid>()
q.push(element: grid(row: 0, col: 0, length: 1))
var ans: Int = 0

while(!q.isEmpty()) {
    let top = q.top()
    q.pop()
    if let current = top {
        if(current.row == N - 1 && current.col == M - 1) {
            ans = current.length
            break
        }
        if(!visitNode[current.row][current.col]) {
            visitNode[current.row][current.col] = true
            for i in 0...3 {
                let nextRow = current.row + dy[i]
                let nextCol = current.col + dx[i]
                if 0 <= nextRow && nextRow < N && 0 <= nextCol && nextCol < M {
                    if(matrix[nextRow][nextCol] == 1) {
                        q.push(element: grid(row: nextRow, col: nextCol, length: current.length + 1))
                        
                    }
                }
            }
            
        }
    }
}


print(ans)
