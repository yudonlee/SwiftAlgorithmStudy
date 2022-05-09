//  [BOJ] 1931 - 회의실 배정
//  2022/05/09

let n = Int(readLine()!)!
var session: [(Int, Int)] = []

for _ in 0..<n {
    let input = readLine()!.split(separator: " ").map{Int($0)!}
    session.append((input[0], input[1]))
}

session.sort {
    if $0.1 == $1.1 {
        return $0.0 < $1.0
    }
    return $0.1 < $1.1
}

var book = 0
var finish = 0

for i in 0..<n {
    if session[i].0 >= finish {
        finish = session[i].1
        book += 1
    }
}

print(book)
