//
//  4781.swift 사탕 가게 Knapsack
//  BaekJoon
//
//  Created by 김원희 on 2022/07/14.
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

while (true) {
    let n = FIO.readInt() //사탕 종류의 수 (보석 번호)
    let m = Int((FIO.readString() as NSString).floatValue * 100 + 0.5)
    
    if n == 0 && m == 0 {
        break
    }
    
    var calories = [Int]()
    var price = [Int]()
    
    var minPrice = 10000
    var c: Int
    var p: Int
    for i in 0...n {
        if i == 0 {
            c = 0
            p = 0
        } else {
            c = FIO.readInt()
            p = Int((FIO.readString() as NSString).floatValue * 100)
        }
        calories.append(c) //칼로리 (가치, 최대로 만들어야 하는 것)
        price.append(p)//가격 (돈의 양 내에서 해결해야 하는 것)
        
        if p < minPrice {
            minPrice = p
        }
    }
    
    var DP: [Int] = Array(repeating: 0, count: m+1)
    for i in minPrice...m { //가격
        for j in 0...n { //사탕 종류
            if price[j] <= i {
                if (DP[i-price[j]]+calories[j]) > DP[i] {
                    DP[i] = (DP[i-price[j]]+calories[j])
                } else {
                    DP[i] = DP[i]
                }
            }
            
        }
        
    }
    
    print(DP[m])
}
