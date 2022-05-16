//
//  2309.swift
//  BaekJoon
//
//  Created by Somin Park on 2022/05/12.
//

import Foundation

//var inputs: [Int] = []

//for _ in 1...9 {
//    let input = readLine()
//    if let input = input {
//        inputs.append(Int(input)!)
//    }
//}
//
//let inputSum = inputs.reduce(0,+)
//
//outerLoop: for i in 0..<inputs.count {
//    for j in (i+1)..<inputs.count {
//        if (inputSum - inputs[i] - inputs[j]) == 100 {
//            inputs.remove(at: i)
//            inputs.remove(at: (j+1))
//            break outerLoop
//        }
//    }
//}
//
//inputs.sorted().forEach{print($0)}

// 입력을 받을 빈 배열
var heights: [Int] = []

// 일곱 난쟁이가 아닌 사람들의 키를 담을 변수
var a: Int = 0
var b: Int = 0

// 여러 줄 입력 받기
for _ in 1...9 {
    heights.append(Int(readLine()!)!)
}

var heightSum = heights.reduce(0, +)

// 이중 for 문을 탈출하는 방법
outerRoop: for i in 0...7 {
    for j in (i + 1)...8 {
        a = heights[i]
        b = heights[j]
        if heightSum - a - b == 100 {
            break outerRoop
        }
    }
}

// 난쟁이가 아닌 a와 b의 index를 찾아서 remove
heights.remove(at: heights.firstIndex(of: a)!)
heights.remove(at: heights.firstIndex(of: b)!)

// 정렬하기
heights.sort()

for i in 0..<heights.count {
    print(heights[i])
}
