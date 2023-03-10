//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2023/03/09.
//

import Foundation



func solution(_ name:String) -> Int {
    var queue: [Int] = []
    var minimumJoystick = Int.max
    let arr = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".enumerated().map { key, value in
        (String(value), min(abs(key - 0), 26 - abs(key - 0)))
    }
    var alphabetDistance: [String: Int] = Dictionary(uniqueKeysWithValues: arr)
    var strArray = name.map { String($0) }
    var totalAlphabet = strArray.reduce(into: 0) { partialResult, str in
        partialResult += alphabetDistance[str]!
    }
    
    
    var targetIndex = strArray.enumerated().filter { $1 != "A" }.map { $0.offset }.sorted()
    
    func dfs(currentIdx: Int, array: [String], targetIdx: [Int], distance: Int) {
        if targetIdx.isEmpty {
            minimumJoystick = min(minimumJoystick, distance)
        }
        let length = array.count
        
        if targetIdx.count > 1 {
            
            let minIdx = targetIdx.first!
            let minLength = min((minIdx - currentIdx + length) % length, (currentIdx - minIdx + length) % length)
            var minTarget = targetIdx
            minTarget.removeFirst()
            
            let maxIdx = targetIdx.last!
            let maxLength = min((maxIdx - currentIdx + length) % length, (currentIdx - maxIdx + length) % length)
            var maxTarget = targetIdx
            maxTarget.removeLast()
            dfs(currentIdx: minIdx, array: array, targetIdx: minTarget, distance: distance + minLength)
            dfs(currentIdx: maxIdx, array: array, targetIdx: maxTarget, distance: distance + maxLength)
        } else if targetIdx.count == 1 {
            let difference = min((targetIdx.first! - currentIdx + length) % length, (currentIdx - targetIdx.first! + length) % length)
            dfs(currentIdx: targetIdx.first!, array: array, targetIdx: [], distance: distance + difference)
        }
        
    }
    
    dfs(currentIdx: 0, array: strArray, targetIdx: targetIndex, distance: 0)
    
    return minimumJoystick + totalAlphabet
}

print(solution("JAZ"))
print(solution("JEROEN"))
print(solution("JAN"))
