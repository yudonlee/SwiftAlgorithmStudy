//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2022/09/14.
//

import Foundation

func notationNumber(_ n: Int, _ k: Int) -> String {
//    var remainder: Int = 0
    var quotient: Int = n
    var result: String = ""
    
    while(quotient > 0) {
        let remainder = quotient % k
        result = String(remainder) + result
        quotient /= k
    }
    
    return result
}

func isNumberPrime(_ num: Int64) -> Bool {
    let iterate = Int64(sqrt(Double(num)))
    if iterate < 2 {
        return true
    }
    for divided in 2...iterate {
        if num % divided == 0 {
            return false
        }
    }
    
    return true
}

func solution(_ n:Int, _ k:Int) -> Int {
    var result = notationNumber(n, k)
    result += "0"
    print(result)
    
    var count: Int = 0
    var numberArray: [String] = []
    var current: String = ""

    result.forEach { char in
        if char != "0" {
            current += String(char)
        } else {
            if !current.isEmpty {
                numberArray.append(current)
                current = ""
            }
        }
    }
    
    
    let decimalArray = numberArray.map { str in
        return Int64(str)!
    }
    
//    소수 판별기
//    0이면 아직 판별 하지 않음, 1은 판별했으나 소수, 2는 판별했으나 소수가 아닌 수
    
    
    decimalArray.filter({ num in
        return num != 1
    }).forEach { num in
    
        if isNumberPrime(num) {
            count += 1
        }
    
    }
    return count
}





