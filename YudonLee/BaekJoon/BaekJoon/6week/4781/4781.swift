//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/07/10.
//

import Foundation

struct Candy {
    var calrorie: Int
    var price: Int
}

while let line = readLine() {
    let input = line.components(separatedBy: " ").map({ Double($0)! })
    let N = Int(input[0])
    let M = Int(input[1] * 100 + 0.05)
    var candies: [Candy] = []
    var DP: [Int] = Array(repeating: 0, count: M + 1)
    
    for _ in 0..<N {
        let candy = readLine()!.components(separatedBy: " ").map({ Double($0)! })
        candies.append(Candy(calrorie: Int(candy[0]), price: Int(candy[1] * 100 + 0.05)))
        let current = Candy(calrorie: Int(candy[0]), price: Int(candy[1] * 100 + 0.05))
        
        for index in 0...(M - current.price) {
            if index + current.price <= M {
                DP[index + current.price] = max(DP[index + current.price], DP[index] + current.calrorie)
            }
        }
        
    }
    if N != 0 {
        print(DP[M])
    }
    
//    Test Rounding error
    print("Rounding Error")
    var count = Array(repeating: 0, count: 10001)
    for test in stride(from: 0.01, through: 100.0, by: 0.01) {
        count[Int(test * 100)] += 1
        if count[Int(test * 100)] > 1 {
            print(Int(test * 100))
        }
    }
    
//    Fix Round off error
    print("Fix Rounding error")
    var countFix = Array(repeating: 0, count: 100000)
    for test in stride(from: 0.01, through: 100.0, by: 0.01) {
        countFix[Int((test + 101.5) * 100)] += 1
        if countFix[Int((test + 101.5) * 100)] > 1 {
            print(Int((test + 101.5) * 100))
        }
    }
}
/*
2 8.00
700 7.00
199 2.00
3 8.00
700 7.00
299 3.00
499 5.00
0 0.00
*/
