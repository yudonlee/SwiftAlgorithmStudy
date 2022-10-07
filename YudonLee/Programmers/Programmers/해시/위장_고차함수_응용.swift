//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2022/10/06.
//

import Foundation

func solution(_ clothes:[[String]]) -> Int {
    let allTypes = clothes.compactMap { $0.last }
    let type = Set(allTypes)
    
    let counts = type.map { category in
        return clothes.filter { dress in
            dress.last! == category
        
        }.count + 1
    }

    let result = counts.reduce(into: 1) { partialResult, value in
        partialResult *= value
    } - 1
    
    return result
}

print(solution([["yellow_hat", "headgear"], ["blue_sunglasses", "eyewear"], ["green_turban", "headgear"]]))
print(solution([["yellow_hat", "headgear"], ["blue_sunglasses", "eyewear"], ["green_turban", "headgear"], ["crow_mask", "face"], ["blue_sunglasses", "face"], ["smoky_makeup", "face"]]))

