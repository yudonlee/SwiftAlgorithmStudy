//  [BOJ] 1654 - 랜선자르기
//  2022/05/15

let kn = readLine()!.split(separator: " ").map{Int($0)!}
var lenght: [Int] = []

for _ in 0..<kn[0] {
    lenght.append(Int(readLine()!)!)
}

var maxLenght = lenght.reduce(0, +) / kn[1]
var minLenght = 1
var rst = 0

while (minLenght <= maxLenght) {
    let mid = (maxLenght + minLenght) / 2
    var countLine = 0
    
    for l in lenght {
        countLine += l / mid
    }
    if countLine < kn[1] {
        maxLenght = mid - 1
    }
    else if countLine >= kn[1] {
        minLenght = mid + 1
        rst = mid
    }
}

print(rst)
