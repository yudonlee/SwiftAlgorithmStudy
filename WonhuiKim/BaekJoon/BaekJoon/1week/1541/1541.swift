//
//  1541.swift
//  BaekJoon
//
//  Created by 김원희 on 2022/05/09.
//

import Foundation

let inputMinus = readLine()!.split(separator: "-").map{ String($0) } //- 기준으로 자름
let beforeMinus = inputMinus[0].split(separator: "+").map{ Int(String($0))! } //- 나오기 전은 모두 덧셈

var answer = 0
for i in beforeMinus {
    answer += i //- 나오기 이전 값들 합산
}

var minusDump = 0 //- 뒤의 숫자 덩어리들
for i in 1..<inputMinus.count {
    let temp = inputMinus[i].split(separator: "+").map{ Int(String($0))! }
    
    for j in temp {
        minusDump += j
    }
}

print(answer - minusDump)


//var temp: Character
//
//var number = ""
//
//var answer = 0
//var minus = false
//
//for i in 0..<input.count {
//    temp = input[input.index(input.startIndex, offsetBy: i)]
//
//
//}

//for i in 0..<input.count {
//    temp = input[input.index(input.startIndex, offsetBy: i)] // 5
//
//    if temp == "+" || temp == "-" || temp == "\0" {
//
//        if temp == "-" {
//            minus = true
//        }
//
//        if minus {
//            answer -= Int(number)!
//        } else {
//            answer += Int(number)!
//        }
//
//        number = ""
//
//    }
//
//    number.append(temp)
//}


//print(answer)

//for i in input {
//    if i == "+" || i == "-" {
////        print("endIdx: \(endIdx)")
//        startIdx = endIdx + 1
////        print("startIdx: \(startIdx)")
////        temp = input[input.index(input.startIndex, offsetBy: startIdx)]
//    }
//    endIdx += 1
//}

