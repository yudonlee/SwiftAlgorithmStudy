//
//  순위검색.swift
//  Programmers
//
//  Created by yudonlee on 2022/09/18.
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
    var dict: [String: Set<Int>] = ["cpp" : [], "java" : [], "python" : [], "backend" : [], "frontend" : [], "junior" : [], "senior" : [], "chicken" : [], "pizza" : [],]
    var people: Set<Int> = []
    var result: [Int] = []
    var scores: [Int] = Array(repeating: 0, count: info.count)
    
    let data = info.sorted { leftInfo, rightInfo in
        let leftItem = leftInfo.components(separatedBy: " ")
        let rightItem = rightInfo.components(separatedBy: " ")
        if Int(leftItem[4])! <= Int(rightItem[4])! {
            return true
        } else {
            return false
        }
    }
    
    for (idx, information) in data.enumerated() {
        let items = information.components(separatedBy: " ")
        items.forEach { item in
            if Int(item) == nil {
                dict[item]?.update(with: idx)
            } else {
                scores[idx] = Int(item)!
            }
        }
        
        people.update(with: idx)
    }
    
    query.forEach { unit in
        let condition = unit.components(separatedBy: " ").filter { str in
            return str != "-" && str != "and"
        }
        var casedPeople = people
        var testNumber = 0
        condition.forEach { str in
            if Int(str) == nil {
                casedPeople = casedPeople.intersection(dict[str]!)
            } else {
                testNumber = Int(str)!
            }
        }
        
        var setToArray: [Int] = Array(casedPeople)
        var findedIndex = -1
        if testNumber > 0 {
            setToArray = setToArray.sorted()
            findedIndex = lowerBound(arr: setToArray, scores: scores, compare: testNumber)
        }
        
        result.append(setToArray.count - findedIndex)
        
    }
    
    return result
}
