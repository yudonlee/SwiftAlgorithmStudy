//  [BOJ] 2512 - 예산
//  2022/05/16

let n = Int(readLine()!)!
var cities = readLine()!.split(separator: " ").map{Int($0)!}
var budget = Int(readLine()!)!
var min = 0
var max = cities.max()!

while (min <= max) {
    let mid = (min + max) / 2
    var total = 0

    for city in cities {
        if (city > mid) { // city 예산이 mid보다 클 경우
            total += mid
        }
        else {
            total += city
        }
    }
    if total <= budget {
        min = mid + 1
    }
    else {
        max = mid - 1
    }
}

print(max)
