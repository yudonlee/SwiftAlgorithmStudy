//  [BOJ] 1026 - 보물
//  2022/05/09

let n = Int(readLine()!)!
var A = readLine()!.split(separator:" ").map{Int($0)!}
var B = readLine()!.split(separator:" ").map{Int($0)!}

A.sort()
B.sort(by: >)

var rst = 0
for i in 0..<n {
    rst += A[i] * B[i]
}

print(rst)
