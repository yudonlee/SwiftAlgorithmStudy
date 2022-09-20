//
//  File.swift
//  Programmers
//
//  Created by yudonlee on 2022/09/15.
//

import Foundation


func solution(_ survey:[String], _ choices:[Int]) -> String {
    let weighted: [Int] = [0, 3, 2, 1, 0, 1, 2, 3]
    let type: [(String, String)] = [("R", "T"), ("C", "F"), ("J", "M"), ("A", "N") ]
    let typeIndex: [String: (Int, Int)] = ["R": (0, 0), "T": (0, 1), "C": (1, 0), "F": (1, 1), "J": (2, 0), "M": (2, 1), "A": (3, 0), "N": (3, 1)]
    
    var score: [(Int, Int)] = [(0, 0), (0, 0), (0, 0), (0, 0)]
    
    for (index, element) in survey.enumerated() {
        
        let currentScore = weighted[choices[index]]
        if currentScore > 0 {
            let winner = choices[index] > 4 ? String(element.last!) : String(element.first!)
            
            switch typeIndex[winner]!.1 {
            case 0:
                score[typeIndex[winner]!.0].0 += currentScore
            case 1:
                score[typeIndex[winner]!.0].1 += currentScore
                
            default:
                break
            }
            
        }
        
        
    }
    
    var result: String = ""
    for (index, element) in score.enumerated() {
        if element.0 < element.1 {
            result += type[index].1
        } else {
            result += type[index].0
        }
    }
    return result
}


print(solution(["AN", "CF", "MJ", "RT", "NA"], [5, 3, 2, 7, 5]))
print(solution(["TR", "RT", "TR"], [7, 1, 3]))
