//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2022/09/17.
//

import Foundation

func lowerBound(arr: [Int], scores: [Int], compare: Int) -> Int {
    var left: Int = 0
    var right: Int = arr.count - 1
    
    while(left <= right){
        let mid: Int = (left + right) / 2
        if(scores[arr[mid]] >= compare) {
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    return left
}


func solution(_ info:[String], _ query:[String]) -> [Int] {
    var dict: [String: [Int]] = [:]
    var result: [Int] = []
    var scores: [Int] = Array(repeating: 0, count: info.count)
    var data: [[String]] = []
    info.forEach { applicant in
        data.append(applicant.components(separatedBy: " "))
    }
    data.sort {
        Int($0[4])! < Int($1[4])!
    }
    
//    Swift sort시 주의점
    
    
    for (idx, items) in data.enumerated() {
        let cases = ["- and - and - and -",
        "\(items[0]) and - and - and -",
        "- and \(items[1]) and - and -",
        "- and - and \(items[2]) and -",
        "- and - and - and \(items[3])",
        "\(items[0]) and \(items[1]) and - and -",
        "\(items[0]) and - and \(items[2]) and -",
        "\(items[0]) and - and - and \(items[3])",
        "- and \(items[1]) and \(items[2]) and -",
        "- and \(items[1]) and - and \(items[3])",
        "- and - and \(items[2]) and \(items[3])",
        "\(items[0]) and \(items[1]) and \(items[2]) and -",
        "\(items[0]) and \(items[1]) and - and \(items[3])",
        "\(items[0]) and - and \(items[2]) and \(items[3])",
        "- and \(items[1]) and \(items[2]) and \(items[3])",
        "\(items[0]) and \(items[1]) and \(items[2]) and \(items[3])",]
        cases.forEach { element in
            dict[element] == nil ? dict[element] = [idx] : dict[element]?.append(idx)
        }
        scores[idx] = Int(items[4])!
    }
    
    query.forEach { unit in
        let condition = unit.components(separatedBy: " ")
        let checkCondition = condition[0...6]
        let testNumber: Int = Int(condition[7]) ?? 0
        let intersectioned = dict[checkCondition.joined(separator: " ")] ?? []
       
        
        let findedIndex = lowerBound(arr: intersectioned, scores: scores, compare: testNumber)
        
        result.append(intersectioned.count - findedIndex)
        
    }
    
    return result
}

print(solution(["java backend junior pizza 150", "python frontend senior chicken 210", "python frontend senior chicken 150", "cpp backend senior pizza 260", "java backend junior chicken 80", "python backend senior chicken 50"], ["java and backend and junior and pizza 100", "python and frontend and senior and chicken 200", "cpp and - and senior and pizza 250", "- and backend and senior and - 150", "- and - and - and chicken 100", "- and - and - and - 150"]))
