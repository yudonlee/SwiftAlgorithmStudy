//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2022/09/18.
//

import Foundation

func solution(_ s:String) -> Int {
    let words: [String] = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    var result = s
    for (idx, checkWord) in words.enumerated() {
        result = result.replacingOccurrences(of: checkWord, with: String(idx))
    }
    return Int(result)!
}

print(solution("one4seveneight"))
print(solution("23four5six7"))
print(solution("2three45sixseven"))
print(solution("123"))



