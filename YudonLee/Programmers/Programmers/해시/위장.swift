//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2022/10/06.
//

func solution(_ clothes:[[String]]) -> Int {
    var categoryCount: [String: Int] = [:]
    var categoryName: [String] = []
    
    clothes.forEach { dress in
        let category = dress[1]
        
        if categoryCount[category] == nil {
//            2로 할당하는 이유는 category를 안 입는것또한 경우의 수임 그래서 +1을 해준다
            categoryCount[category] = 2
            categoryName.append(category)
        } else {
            categoryCount[category]! += 1
        }
    }
    
    
    let result = categoryName.reduce(into: 1) { partialResult, idx in
        partialResult *= categoryCount[idx]!
    } - 1
    
    return result
}

print(solution([["yellow_hat", "headgear"], ["blue_sunglasses", "eyewear"], ["green_turban", "headgear"]]))
print(solution([["yellow_hat", "headgear"], ["blue_sunglasses", "eyewear"], ["green_turban", "headgear"], ["crow_mask", "face"], ["blue_sunglasses", "face"], ["smoky_makeup", "face"]]))
