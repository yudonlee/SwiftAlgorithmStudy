//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2022/10/06.
//

import Foundation

func solution(_ clothes:[[String]]) -> Int {
    var weightList: [String: Int] = [:]
    clothes.forEach { dress in
        if weightList[dress.last!] == nil {
            weightList[dress.last!] = 2
        } else {
            weightList[dress.last!]! += 1
        }
    }
    
    return weightList.reduce(into: 1) { $0 *= $1.value} - 1
}

print(solution([["yellow_hat", "headgear"], ["blue_sunglasses", "eyewear"], ["green_turban", "headgear"]]))
print(solution([["yellow_hat", "headgear"], ["blue_sunglasses", "eyewear"], ["green_turban", "headgear"], ["crow_mask", "face"], ["blue_sunglasses", "face"], ["smoky_makeup", "face"]]))

