//  [BOJ] 2309 - 일곱난쟁이
//  2022/05/09

var dwarfs: [Int] = []
var x = 0

// 모든 난쟁이의 키를 배열로 받는다. 이때, 모든 키의 합도 구한다.
for _ in 0..<9 {
    let dwarf = Int(readLine()!)!
    x += dwarf
    dwarfs.append(dwarf)
    print(dwarf)
}

x -= 100

// 9명 중 7명의 합이 100이므로, 2명은 '전체키 - 100'의 값을 갖는다.
outerLoop: for i in 0..<9 {
    for j in 0..<9 {
        if ((dwarfs[i] + dwarfs[j] == x) && (i != j)) {
            // 첫째항 정상 출력
            dwarfs[i] = 100
            dwarfs[j] = 100
            break outerLoop
        }
    }
}

// 주어진 배열을 정렬한 후 작은 순으로 7개 출력
print(dwarfs.sorted()[0..<7].map({String($0)}).joined(separator: "\n"))

// 결과값은 맞는데 왜 틀렸다고 뜰까요?
