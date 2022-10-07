//
//  File.swift
//  Programmers
//
//  Created by yudonlee on 2022/10/06.
//

import Foundation

func combination(_ combi: inout [[Int]], _ arr: [String], unitCase: [Int], depth: Int) {
    if depth == arr.count {
        if !unitCase.isEmpty {
            combi.append(unitCase)
        }
    } else {

        combination(&combi, arr, unitCase: unitCase, depth: depth + 1)
        combination(&combi, arr, unitCase: unitCase + [depth], depth: depth + 1)
    }
}

func solution(_ clothes:[[String]]) -> Int {
    var categoryCount: [String: Int] = [:]
    var categoryName: [String] = []
    var result = 0
    
    clothes.forEach { dress in
        let category = dress[1]
        
        if categoryCount[category] == nil {
//            2로 할당하는 이유는 category를 안 입는것또한 경우의 수임 그래서 +1을 해준다
            categoryCount[category] = 1
            categoryName.append(category)
        } else {
            categoryCount[category]! += 1
        }
    }
    
    var allCases: [[Int]] = []
    combination(&allCases, categoryName, unitCase: [], depth: 0)
    
    allCases.forEach { unitCombination in
    
        let numberOfCases = unitCombination.reduce(into: 1) { partialResult, index in
            partialResult *= categoryCount[categoryName[index]]!
        }
        
        result += (numberOfCases)
    }
    
    return result
}

print(solution([["yellow_hat", "headgear"], ["blue_sunglasses", "eyewear"], ["green_turban", "headgear"]]))
print(solution([["yellow_hat", "headgear"], ["blue_sunglasses", "eyewear"], ["green_turban", "headgear"], ["crow_mask", "face"], ["blue_sunglasses", "face"], ["smoky_makeup", "face"]]))




