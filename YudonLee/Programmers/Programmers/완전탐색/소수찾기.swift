//
//  main.swift
//  Programmers
//
//  Created by 이유돈 on 2023/02/24.
//

import Foundation

func isPrime(n: Int) -> Bool {
    if n < 2 {
        return false
    }
    if n < 4 {
        return true
    }
    let root = Int(sqrt(Double(n)))
    for i in 2...root {
        if n % i == 0 {
            return false
        }
    }
    return true
}

func solution(_ numbers:String) -> Int {
    var result = 0
    var allCases = Set<String>()
    
    func makeNumbers(_ result: String, _ unused: String) {
        if unused.isEmpty {
            allCases.insert(result)
            return
        } else if !result.isEmpty {
            allCases.insert(result)
        }
        for item in unused.enumerated() {
            var newUnused = unused
            let index = newUnused.index(newUnused.startIndex, offsetBy: item.offset)
            newUnused.remove(at: index)
            makeNumbers(result + String(item.element), newUnused)
        }
    }
    makeNumbers("", numbers)
    var numberList = Array(repeating: 0, count: 10000000)
    allCases.forEach {
        let number = Int($0)!
        if isPrime(n: number), numberList[number] == 0 {
            numberList[number] += 1
            result += 1
        }
    }
    
    return result
}
//
//print(solution("0"))
//print(solution("1"))
//print(solution("2"))
//print(solution("3"))
print(solution("011"))
//print(solution("17"))
