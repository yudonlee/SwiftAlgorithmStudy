//
//  1759.swift 암호 만들기 (back tracking)
//  BaekJoon
//
//  Created by 김원희 on 2022/07/19.
//

import Foundation

final class FileIO {
    private let buffer: Data
    private var index: Int = 0
    
    init(fileHandle: FileHandle = FileHandle.standardInput) {
        self.buffer = try! fileHandle.readToEnd()! // 인덱스 범위 넘어가는 것 방지
    }
    
    @inline(__always) private func read() -> UInt8 {
        defer {
            index += 1
        }
        guard index < buffer.count else { return 0 }
        
        return buffer[index]
    }
    
    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true
        
        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }
        
        return sum * (isPositive ? 1:-1)
    }
    
    
    @inline(__always) func readString() -> String {
        var str = ""
        var now = read()
        
        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        
        while now != 10
                && now != 32 && now != 0 {
            str += String(bytes: [now], encoding: .ascii)!
            now = read()
        }
        
        return str
    }
}

let FIO = FileIO()
let L = FIO.readInt() //조합해야 하는 알파벳 수 (depth)
let C = FIO.readInt() //주어지는 알파벳 수

var alphabet = [String]()
for _ in 0..<C {
    alphabet.append(FIO.readString())
}

var visit: [Bool] = Array(repeating: false, count: C)
var answer: [Int] = Array(repeating: 0, count: L)

alphabet.sort() //정렬 - 알파벳이 암호에서 증가하는 순서로 배열되었을 것
bt(depth: 0, cur: 0)

func bt(depth: Int, cur: Int) {
    if depth == L {
        if checkCondition() {
            for i in answer {
                print(alphabet[i], terminator: "")
            }
            print()
        }
        return
    }
    
    for i in cur..<C {
        if !visit[i] {
            visit[i] = true
            answer[depth] = i
            bt(depth: depth+1, cur: i)
            visit[i] = false
        }
    }
}

func checkCondition() -> Bool { //조건- 최소 한 개의 모음(a, e, i, o, u)과 최소 두 개의 자음으로 구성
    var vowel = 0 //모음 개수
    var consonant = 0 //자음 개수
    
    for i in answer {
        if alphabet[i] == "a" || alphabet[i] == "e" || alphabet[i] == "i"
            || alphabet[i] == "o" || alphabet[i] == "u" {
            vowel += 1
        } else {
            consonant += 1
        }
    }
    
    if vowel >= 1 && consonant >= 2 {
        return true
    } else {
        return false
    }
}


