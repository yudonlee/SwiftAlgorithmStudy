//  [BOJ] 18111 - 마인크래프트
//  2022/05/09

let input = readLine()!.split(separator:" ").map{ Int($0)! }
let h = input[0]
let w = input[1]
var matrix: [[Int]] = []
var rstTime = 987654321
var rstLayer = -1
var currentlayer = 256

for _ in 0..<h {
    let input = readLine()!.split(separator:" ").map{Int($0)!}
    matrix.append(input)
}

while (currentlayer >= 0) {
    var currentTime = 0
    var currentInventory = input[2]

    for i in 0..<h {
        for j in 0..<w {
            if (matrix[i][j] > currentlayer) {
                currentInventory += (matrix[i][j] - currentlayer)
                currentTime += (matrix[i][j] - currentlayer) * 2
            }
            else if (matrix[i][j] < currentlayer) {
                currentInventory -= (currentlayer - matrix[i][j])
                currentTime += (currentlayer - matrix[i][j])
            }
        }
    }

    if (currentInventory >= 0) {
        if (currentTime < rstTime) {
            rstTime = currentTime
            rstLayer = currentlayer
        }
    }
    currentlayer -= 1
}

print(String(rstTime) + " " + String(rstLayer))
