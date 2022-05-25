//  [BOJ] 10816 - 숫자 카드 2
//  2022/05/10

let n = readLine()!
var A = readLine()!.split(separator: " ").map{Int($0)!}.sorted()
let m = readLine()!
var targets = readLine()!.split(separator: " ").map{Int($0)!}
var rst = ""
var dic: [Int: Int] = [:] // key:value

for i in A {
    dic[i] = dic.keys.contains(i) ? dic[i]! + 1 : 1
}

for target in targets {
    if dic.keys.contains(target) {
        rst += "\(dic[target]!) "
    }
    else {
        rst += "\(0) "
    }
}

print(rst)
