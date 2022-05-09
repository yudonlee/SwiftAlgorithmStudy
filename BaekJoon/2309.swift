//
//  main.swift
//  BaekJoon
//
//  Created by Lena on 2022/05/09.
//

//2309
import Foundation

var numbers:[Int] = []
var sumHeight: Int = 0

var first: Int = 0
var second: Int = 0

for i in 0...8 {
    numbers.append(Int(readLine()!)!)
    sumHeight += numbers[i]
}

outerLoop: for i in 0...7 {
    for j in (i+1)...8 {
        first = numbers[i]
        second = numbers[j]
        if sumHeight - first - second == 100 {
            break outerLoop
        }
        
    }
}
numbers.remove(at: numbers.firstIndex(of: first)!)
numbers.remove(at: numbers.firstIndex(of: second)!)

numbers.sort()

for i in numbers {
    print(i)
    
}
