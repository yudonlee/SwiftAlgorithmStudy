//  [BOJ] 10830 - 행렬 제곱
//  2022/05/10

let NB = readLine()!.split(separator: " ").map{Int($0)!}
var matrix: [[Int]] = []
let mod = 1000

for _ in 0..<NB[0] {
    matrix.append(readLine()!.split(separator: " ").map{Int($0)! % mod})
}

func multiply (A: [[Int]], B: [[Int]]) -> [[Int]] {
    var M = A
    for i in 0..<NB[0] {
        for j in 0..<NB[0] {
            M[i][j] = 0
            for k in 0..<NB[0] {
                M[i][j] += A[i][k] * B[k][j] % mod
                M[i][j] %= mod
            }
        }
    }
    return M
}

func power(M: [[Int]], b: Int) -> [[Int]] {
    if b == 1 { return M }
    var divM = power(M: M, b: b / 2)
    divM = multiply(A: divM, B: divM)
    if b % 2 != 0 {
        divM = multiply(A: divM, B: M)
    }
    return (divM)
}

let rst = power(M: matrix, b: NB[1])
for row in rst {
    print(row.map{String($0)}.joined(separator: " "))
}
