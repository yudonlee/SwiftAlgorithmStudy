//  [BOJ] 2805 - 나무 자르기
//  2022/05/17

let nm = readLine()!.split(separator: " ").map{Int($0)!}
var ls = readLine()!.split(separator: " ").map{Int($0)!}

var right = ls.max()!
var left = 0
var answer = 0

func countTimber(num: Int) -> Int {
    var count = 0
    for x in ls {
        if (x > num) {
            count += (x - num)
        }
    }
    return count
}

while (left <= right) {
    let cutLenght = (left + right) / 2
    let x = countTimber(num: cutLenght)
    if (x < nm[1]) {
        right = cutLenght - 1
    }
    else if (x >= nm[1]) {
        left = cutLenght + 1
        answer = cutLenght
    }
}

print(answer)
