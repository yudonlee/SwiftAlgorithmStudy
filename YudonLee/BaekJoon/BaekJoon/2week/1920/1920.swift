//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/05/10.
//

import Foundation

let N: Int = Int(readLine()!)!
var arr: [Int] = readLine()!.components(separatedBy: " ").map({ Int($0)!})
arr.sort()

let M: Int = Int(readLine()!)!
let findList: [Int] = readLine()!.components(separatedBy: " ").map({ Int($0)!})
for findNumber in findList {
    
    let size: Int = arr.count
    var left: Int = 0
    var right: Int = size - 1
    var status: Bool = false
    
    while(left <= right) {
        let mid:Int = (left + right) / 2
        if(arr[mid] == findNumber) {
            status = true;
            break;
        } else if(arr[mid] > findNumber) {
            right = mid - 1
        } else {
            left = mid + 1
        }
//        print("left: \(left) right: \(right) mid: \(mid)")
    }
    
    if(status) {
        print(1)
    } else {
        print(0)
    }
}
