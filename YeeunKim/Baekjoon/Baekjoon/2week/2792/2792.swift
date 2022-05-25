//  [BOJ] 2792 - 보석상자
//  2022/05/15

let nm = readLine()!.split(separator: " ").map{Int($0)!}
var beads: [Int] = []
var max = 0
var min = 1

for _ in 0..<nm[1] {
    let tmp = Int(readLine()!)!
    beads.append(tmp)
    if tmp > max {
        max = tmp
    }
}

while (min <= max) {
    let mid = (min + max) / 2
    var countBead = 0

    for bead in beads {
        countBead += bead / mid
        if (bead % mid != 0) {
            countBead += 1
        }
    }
    if countBead > nm[0] {
        min = mid + 1
        
    }
    else {
        max = mid - 1
    }
}

print(min)
