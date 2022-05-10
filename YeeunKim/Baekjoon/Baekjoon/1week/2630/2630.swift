//  [BOJ] 2630 - 색종이 만들기
//  2022/05/10

let n = Int(readLine()!)!
var sheet: [[Int]] = []
var blueSheet = 0
var whiteSheet = 0

for _ in 0..<n {
    let input = readLine()!.split(separator:" ").map{Int($0)!}
    sheet.append(input)
}

func div_cn(x: Int, y: Int, size:Int) {
    let color = sheet[x][y]
    let next = size / 2
    
    for i in x..<(x + size) {
        for j in y..<(y + size) {
            if color != sheet[i][j] {
                div_cn(x: x, y: y, size: next)
                div_cn(x: x, y: y + next, size: next)
                div_cn(x: x + next, y: y, size: next)
                div_cn(x: x + next, y: y + next, size: next)
                return
            }
        }
    }
    if color == 1 {
        blueSheet += 1
    }
    
    else {
        whiteSheet += 1
    }
}

div_cn(x: 0, y: 0, size: n)
print(whiteSheet)
print(blueSheet)
