//
//  main.swift
//  BaekJoon
//
//  Created by 김원희 on 2022/05/09.
//

import Foundation

let length = Int(readLine()!)

var arrA = [Int]()
var arrB = [Int]()

let inputA = readLine()!.split(separator: " ").map{ Int(String($0))! }
let inputB = readLine()!.split(separator: " ").map{ Int(String($0))! }

//print(type(of: inputA))

for i in 0..<length! {
    arrA.append(inputA[i])
    arrB.append(inputB[i])
}

arrA.sort() //오름차순 정렬
arrB.sort(by: >) //내림차순 정렬

var answer = 0
for i in 0..<length! {
    answer += arrA[i] * arrB[i]
}

print(answer)






