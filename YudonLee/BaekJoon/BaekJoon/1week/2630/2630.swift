//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/05/10.
//

import Foundation

var N: Int = Int(readLine()!)!

var arr: [[Int]] = []

for _ in 0..<N {
    let row = readLine()!.components(separatedBy: " ").map({
        Int($0)!
    })
    arr.append(row)
}

func divide(left: Int, right: Int, size: Int) {
    if(N == 1)
    var rowMid: Int = (left + right) / 2
    var colMid: Int =
    divide(left: left, right: rowMid)
    divide(left: rowMid + 1, right: right)
    divide(left: <#T##Int#>, right: <#T##Int#>)
}
