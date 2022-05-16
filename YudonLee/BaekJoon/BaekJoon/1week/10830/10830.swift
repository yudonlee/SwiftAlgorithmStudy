import Foundation

var num: [Int] = readLine()!.components(separatedBy: " ").map({ Int($0)!
})
var (N, B) = (num[0], CLongLong(num[1]))

func mul(leftMatrix: [[CLongLong]], rightMatrix: [[CLongLong]]) -> [[CLongLong]] {
    var mulMatrix: [[CLongLong]] = Array(repeating: Array(repeating: 0, count: N), count: N)
    for i in 0..<N {
        for j in 0..<N {
            for k in 0..<N {
                mulMatrix[i][k] += leftMatrix[i][j] * rightMatrix[j][k]
                mulMatrix[i][k] %= 1000
            }
        }
    }
    return mulMatrix
}

func calculate(matrix: [[CLongLong]], B: CLongLong) -> [[CLongLong]]{
    
    if(B == 1) {
        return matrix
    } else if(B % 2 == 0) {
        return calculate(matrix: mul(leftMatrix: matrix, rightMatrix: matrix), B: (B / 2))
    } else {
        return mul(leftMatrix: calculate(matrix: mul(leftMatrix: matrix, rightMatrix: matrix), B: (B / 2)), rightMatrix:matrix)
    }
}


var matrix: [[CLongLong]] = []

for _ in 0..<N {
    let row: [CLongLong] = readLine()!.components(separatedBy: " ").map({ CLongLong($0)!
    })
    matrix.append(row)
}

var result: [[CLongLong]] = calculate(matrix: matrix, B: B)

for i in 0..<N{
    for j in 0..<N{
        print(result[i][j] % 1000, terminator: " ")
    }
    print()
}
