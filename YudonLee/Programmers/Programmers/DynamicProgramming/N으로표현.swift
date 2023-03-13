//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2023/03/10.
//

import Foundation


func solutions(_ N:Int, _ number:Int) -> Int {
    if N == number {
        return 1
    }
    
    var possibles = Array(repeating: [Int](), count: 9)
    possibles[1] = [N]
    
    for count in 2...8 {
        possibles[count-1].forEach {
            var cases = [$0 * N,
                         $0 + N,
                         $0 - N,
                         N - $0]
            if N != 0 {
                cases.append(Int($0 / N))
            }
            if $0 != 0 {
                cases.append(Int(N / $0))
            }
            cases.forEach { possibles[count].append($0) }
        }
        
        if count > 3 {
            possibles[count-2].forEach { value in
                possibles[2].forEach { nextValue in
                    var cases = [value * nextValue,
                                 value + nextValue,
                                 value - nextValue,
                                 nextValue * value]
                    if value != 0 {
                        cases.append(Int(nextValue / value))
                    }
                    if nextValue != 0 {
                        cases.append(Int(value / nextValue))
                    }
                    cases.forEach { possibles[count].append($0) }
                    
                }
            }
        }
        
        if count > 4 {
            possibles[count-3].forEach { value in
                possibles[3].forEach { nextValue in
                    var cases = [value * nextValue,
                                 value + nextValue,
                                 value - nextValue,
                                 nextValue * value]
                    if value != 0 {
                        cases.append(Int(nextValue / value))
                    }
                    if nextValue != 0 {
                        cases.append(Int(value / nextValue))
                    }
                    cases.forEach { possibles[count].append($0) }
                    
                }
            }
        }
        
        
        possibles[count].append(Int(String(repeating: Character(String(N)), count: count))!)
    }
    
    for count in 2...8 {
        for item in possibles[count] {
            if item == number {
                return count
            }
        }
    }
    
    return -1
}
print(solutions(3, 4))
print(solutions(5, 12))
print(solutions(2, 11))
print(solutions(4, 31))
print(solutions(6, 5))
//N : 6
//number : 5
