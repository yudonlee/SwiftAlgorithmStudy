//  [BOJ] 1541 - 잃어버린 괄호
//  2022/05/10

let cmd = readLine()!.split(separator: "-")
var rst = 0

for (idx, num) in cmd.enumerated() {
    let sum = num.split(separator: "+").map{Int($0)!}.reduce(0, +)
    if idx == 0 {
        rst += sum
    }
    else {
        rst -= sum
    }
}

print(rst)
