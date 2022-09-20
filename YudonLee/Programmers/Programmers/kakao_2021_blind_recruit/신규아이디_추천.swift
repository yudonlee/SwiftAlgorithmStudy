//
//  File.swift
//  Programmers
//
//  Created by yudonlee on 2022/09/16.
//

import Foundation

func solution(_ new_id:String) -> String {
//    1단계
    var converted = new_id.lowercased()
//    2단계
    let filtered = "abcdefghijklmnopqrstuvwxyz1234567890-_."
    converted = converted.filter { char in
        filtered.contains(char)
    }
//    3단계
    while(converted.contains("..")){
        converted = converted.replacingOccurrences(of: "..", with: ".")
    }
    
//    4단계
    
    if let first = converted.first, first == "." {
        converted.removeFirst()
    }
    
    if let last = converted.last, last == "." {
        converted.removeLast()
    }
    
//    5단계
    if converted.isEmpty {
        converted = "a"
    }
    
//    6단계
    if converted.count > 15 {
        let lastIdx = converted.index(converted.startIndex, offsetBy: 15)
        converted = String(converted[converted.startIndex ..< lastIdx])
        
        if converted.last == "." {
            converted.removeLast()
        }
    }
    
    while(converted.count <= 2) {
        converted += String(converted.last!)
    }
    
    
    return converted
}


print(solution("...!@BaT#*..y.abcdefghijklm"))
print(solution(    "z-+.^."))
print(solution(    "=.="))
print(solution(    "123_.def"))
print(solution(    "abcdefghijklmn.p"))
