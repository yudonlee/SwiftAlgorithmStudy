//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2022/05/10.
//

import Foundation


//Swift에선 parameter를 포인터로 전달하는가? 참조를 어떤 방식으로 하는가
final class FileIO {
    private let buffer:[UInt8]
    private var index: Int = 0

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        
        buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }

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
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
    }

    @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return Array(buffer[beginIndex..<(index-1)])
    }
}

let FIO = FileIO()

var N = FIO.readInt()
var arr: [Int] = []

for _ in 0..<N{
    arr.append(FIO.readInt())
}

var sorted = [Int](repeating: 0, count: N)
var count: CLongLong = 0

func mergeSort(left: Int, right: Int) {
    if(left < right) {
        var mid: Int = Int((left + right) / 2)
        mergeSort(left: left, right: mid)
        mergeSort(left: mid + 1, right: right)
        merge(left: left, mid: mid, right: right)
    }
}

func merge(left: Int, mid: Int, right: Int) {
    var leftStartIndex: Int = left
    var rightStartIndex: Int = mid + 1
    var sortedIndex:Int = 0
    while(leftStartIndex <= mid && rightStartIndex <= right) {
        if(arr[leftStartIndex] > arr[rightStartIndex]) {
//            sorted.append(arr[rightStartIndex])
            sorted[sortedIndex] = arr[rightStartIndex]
            count += Int64(mid - leftStartIndex + 1)
            rightStartIndex += 1
        } else {
            sorted[sortedIndex] = arr[leftStartIndex]
//            sorted.append(arr[leftStartIndex])
            leftStartIndex += 1
        }
        sortedIndex += 1
    }
    
    while(leftStartIndex <= mid) {
//        sorted.append(arr[leftStartIndex])
        sorted[sortedIndex] = arr[leftStartIndex]
        leftStartIndex += 1
        sortedIndex += 1
//        count += 1
    }
    while(rightStartIndex <= right) {
//        sorted.append(arr[rightStartIndex])
        sorted[sortedIndex] = arr[rightStartIndex]
        rightStartIndex += 1
        sortedIndex += 1
    }
    
    var leftCopy:Int = left
    
    for i in 0..<sortedIndex{
        arr[leftCopy] = sorted[i]
        leftCopy += 1
    }
    
}

mergeSort(left: 0, right: N - 1)
//print(arr)
print(count)


