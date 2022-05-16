//
//  File.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/05/09.
//

import Foundation


//Swift에선 parameter를 포인터로 전달하는가? 참조를 어떤 방식으로 하는가

func mergeSort(left: Int, right: Int, arr: [Int]) {
    if(left < right) {
        var mid: Int = (left + right) / 2
        mergeSort(left: left, right: mid, arr: arr)
        mergeSort(left: mid + 1, right: right, arr: arr)
        merge(left, mid, right, arr: arr)
    }
}

func merge(left: Int, mid: Int, right: Int, arr: [Int]) {
    var leftStartIndex: Int = left
    var rightStartIndex: Int = mid + 1
    var sorted: Int = []
    while(leftStartIndex <= mid && rightStartIndex <= right) {
        if(arr[leftStartIndex] > arr[rightStartIndex]) {
            sorted.append(arr[rightStartIndex])
            rightStartIndex += 1
        } else {
            sorted.append(arr[leftStartIndex])
            leftStartIndex += 1
        }
    }
    
    
}
var N:Int = Int(readLine()!)!
var arr = readLine()!.components(separatedBy: " ").map({Int($0)})

mergeSor

