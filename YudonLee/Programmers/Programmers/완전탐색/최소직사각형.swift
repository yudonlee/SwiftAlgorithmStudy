//
//  main.swift
//  Programmers
//
//  Created by 이유돈 on 2023/02/24.
//

import Foundation

func solution(_ sizes:[[Int]]) -> Int {
    var smallerMax: Int = -1
    var largerMax: Int = -1
    sizes.forEach {
        let small: Int = min($0[0], $0[1])
        let large: Int = max($0[0], $0[1])
        
        smallerMax = max(smallerMax, small)
        largerMax = max(largerMax, large)
    }
    
    return smallerMax * largerMax
}

