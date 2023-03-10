//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2023/03/09.
//

import Foundation

func solution(_ number:String, _ k:Int) -> String {
    var remainder = k
    var strRemainder = number.map { return String($0) }
    
    for currentIndex in 0..<strRemainder.count - 1 {
        if remainder == 0 {
            break
        }
        let currentValue = Int(strRemainder[currentIndex])!
        if currentValue == 9 {
            continue
        }
        var status = false
        
        for nextIndex in currentIndex + 1..<min(currentIndex + remainder + 1, strRemainder.count - 1)  {
            let nextValue = Int(strRemainder[nextIndex])!
            if nextValue > currentValue {
                status = true
                break
            }
        }

        if status {
            strRemainder[currentIndex] = ""
            remainder -= 1
        }
    }

    var elementIndex = Array(repeating: [Int](), count: 10)
    var start = 0
    
    strRemainder.enumerated().forEach {
        if let value = Int($1) {
            elementIndex[value].append($0)
        }
    }
    
    while(remainder > 0) {
        if start > 9 {
            break
        }
        while !elementIndex[start].isEmpty {
            let idx = elementIndex[start].removeLast()
            strRemainder[idx] = ""
            remainder -= 1
        }
        start += 1
    }
    
    return strRemainder.joined()
}


print(solution("1924", 2))
print(solution("1231234", 3))
print(solution("4177252841", 4))
