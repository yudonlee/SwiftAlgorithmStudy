//  [BOJ] 2309 - 일곱 난쟁이
//  2022/05/09

var dwarfs: [Int] = []
var x = 0

// 모든 난쟁이의 키를 배열로 받는다. 이때, 모든 키의 합도 구한다.
for _ in 0..<9 {
    let dwarf = Int(readLine()!)!
    x += dwarf
    dwarfs.append(dwarf)
}

x -= 100
var spy1 = 0
var spy2 = 0

// 9명 중 7명의 합이 100이므로, 2명은 '전체키 - 100'의 값을 갖는다.
outerLoop: for i in 0..<8 {
    for j in (i+1)..<9 {
        if (dwarfs[i] + dwarfs[j] == x) {
            spy1 = i
            spy2 = j
            break outerLoop
        }
    }
}

// 주어진 배열을 정렬한 후 작은 순으로 7개 출력
var real: [Int] = []
for i in 0..<9 {
    if i == spy1 || i == spy2 { continue }
    real.append(dwarfs[i])
}

real.sort()

for i in real {
    print(i)
}
