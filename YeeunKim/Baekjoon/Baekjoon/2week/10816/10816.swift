//  [BOJ] 10816 - 숫자 카드 2
//  2022/05/10

let n = readLine()!
var A = readLine()!.split(separator: " ").map{Int($0)!}.sorted()
let m = readLine()!
var targets = readLine()!.split(separator: " ").map{Int($0)!}
var rst: [Int] = []
//var dic: [Int: Int] = [:] // key:value
// dic로 해당 값을 찾는 방법도 있는데, n이 클 경우 의미가 있는지 모르겠다.

// 시간 초과
// 해당 인덱스를 반환
func binarySearch(_ array: [Int], _ target: Int) -> Int {
    var start = 0
    var end = array.count - 1
    
    while (start <= end) {
        let mid = (start + end) / 2
        if (array[mid] == target) {
            return mid
        }
        else if (array[mid] < target) {
            start = mid + 1
        }
        else if (array[mid] > target) {
            end = mid - 1
        }
    }
    return -1
}

// bs로 얻은 인덱스 기준으로 전~후 target이 있는지 확인
func countTarget(_ array: [Int], _ index: Int) -> Int {
    var counts = 0
    var i = index - 1
    while (i >= 0) {
        if (array[i] == array[index]) {
            counts += 1
        }
        i -= 1
    }
    for i in index..<array.count {
        if (array[i] == array[index]) {
            counts += 1
        }
    }
    return (counts)
}



// 갯수 확인
for target in targets {
    if (binarySearch(A, target) == -1) {
        rst.append(0)
    }
    else {
        rst.append(countTarget(A, binarySearch(A, target)))
    }
}

print(rst.map{String($0)}.joined(separator: " "))
