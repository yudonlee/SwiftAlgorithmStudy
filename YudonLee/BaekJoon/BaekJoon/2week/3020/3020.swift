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

func lowerBound(arr: [Int], N: Int, compare: Int) -> Int {
    var left: Int = 0
    var right: Int = N
    
    while(left < right) {
        let mid: Int = (left + right) / 2
        if(arr[mid] >= compare) {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func upperBound(arr: [Int], N: Int, compare: Int) -> Int {
    var left: Int = 0
    var right: Int = N
    
    while(left < right) {
        let mid: Int = (left + right) / 2
        if(arr[mid] > compare) {
            right = mid
        } else {
            left = mid  + 1
        }
    }
    return left
}

let FIO = FileIO()

var N = FIO.readInt()
var H = FIO.readInt()
let maxCount: Int = 1000000
//var heightCount: [Int] = Array(repeating: 0, count: 500001)
var minCount: [Int] = Array(repeating: 0, count: 500001)

var oddArray: [Int] = []
var evenArray: [Int] = []
var arr: [Int] = []

for i in 0..<N {
    let input: Int = FIO.readInt()
    if(i % 2 == 0) {
        evenArray.append(input)
    } else {
        oddArray.append(input)
    }
}

oddArray.sort()
evenArray.sort()

var minValue:Int = maxCount

for i in 1...H {
    let lower: Int = lowerBound(arr: evenArray, N: evenArray.count, compare: i)
    let upper: Int = lowerBound(arr: oddArray, N: oddArray.count, compare: H - i + 1)
    
    
    let up: Int = evenArray.count - lower
    let down: Int = oddArray.count - upper
    
    minCount[up + down] += 1
    
    if(minValue > up + down) {
        minValue = up + down
    }
}

print("\(minValue) \(minCount[minValue])")


