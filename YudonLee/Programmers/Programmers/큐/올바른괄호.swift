//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2022/10/07.
//

import Foundation

func solution(_ s:String) -> Bool
{
    var leftCount: Int = 0
    var rightCount: Int = 0
    
    for top in s {
        leftCount += top == "(" ? 1 : 0
        rightCount += top == ")" ? 1 : 0
        
        if leftCount < rightCount {
            break
        }
        
    }
    
    if leftCount != rightCount {
        return false
    }

    return true
}

print(solution("()()"))
print(solution("(())()"))
print(solution(")()("))
print(solution("(()("))

//"()()"    true
//"(())()"    true
//")()("    false
//"(()("    false
