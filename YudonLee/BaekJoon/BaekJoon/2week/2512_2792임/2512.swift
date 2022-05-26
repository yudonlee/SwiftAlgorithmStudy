

import Foundation

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
var M = FIO.readInt()
var marble: [Int] = Array(repeating: 0, count: 300000)
var maxValue: Int = 1

for i in 0..<M {
    marble[i] = FIO.readInt()
    if(marble[i] > maxValue) {
        maxValue = marble[i]
    }
}

var left: Int = 1
var right: Int = 1000000001
var ans: Int = 0

func minNeededPerson(divide: Int, arr: [Int], M: Int) -> CLongLong {
    var count: CLongLong = 0
    
    for i in 0..<M {
        let items: Int = arr[i]
        
        let divided: Int = Int(items / divide)
        
        count += Int64(divided)
        
        if(items % divide > 0) {
            count += 1
        }
    }
//    print("\(divide) is \(count)")
    return count
}

while(left <= right) {
    let mid: Int = (left + right) / 2
    if(minNeededPerson(divide: mid, arr: marble, M: M) <= N) {
        ans = mid
        right = mid - 1
    } else {
        left = mid + 1
    }
}
// left < right 해서 맞지 않았다
// Binary Search시 어떨떈 <만, 어떨떈 <=를 해야하는데 무엇이 맞는걸까? 

print(ans)

