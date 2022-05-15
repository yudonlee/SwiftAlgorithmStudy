//
//  main.swift
//  BaekJoon
//
//  Created by Lena on 2022/05/09.
//

import Foundation

let n = Int(readLine()!)!
let a = readLine()!.split(separator: " ").map{Int(String($0))!}.sorted(by: >)
let b = readLine()!.split(separator: " ").map{Int(String($0))!}.sorted(by: <)
// b 재배열하지 않고는 안되나?
var sum = 0

for i in 0..<n {
    sum += a[i] * b[i]
}

print(sum)
