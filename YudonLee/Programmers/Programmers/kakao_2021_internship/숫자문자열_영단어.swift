//
//  File.swift
//  Programmers
//
//  Created by yudonlee on 2022/09/18.
//
import Foundation

func solution(_ s:String) -> Int {
    let dict: [String: String] = ["zero": "0", "one": "1", "two": "2", "three": "3", "four": "4", "five": "5", "six": "6", "seven": "7", "eight": "8", "nine": "9"]
    var checked: [Character] = []
    var result: String = ""
    s.forEach { char in
        char.isNumber ? result += String(char) : checked.append(char)
        if let number = dict[String(checked)] {
            result += number
            checked = []
        }
    }
    return Int(result)!
}

print(solution("one4seveneight"))
print(solution("23four5six7"))
print(solution("2three45sixseven"))
print(solution("123"))

