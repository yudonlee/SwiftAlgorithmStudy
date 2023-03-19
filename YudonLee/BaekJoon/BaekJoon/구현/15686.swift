//
//  main.swift
//  BaekJoon
//
//  Created by yudonlee on 2023/03/17.
//

//15686
//크기가 N×N인 도시가 있다. 도시는 1×1크기의 칸으로 나누어져 있다. 도시의 각 칸은 빈 칸, 치킨집, 집 중 하나이다. 도시의 칸은 (r, c)와 같은 형태로 나타내고, r행 c열 또는 위에서부터 r번째 칸, 왼쪽에서부터 c번째 칸을 의미한다. r과 c는 1부터 시작한다.
//
//이 도시에 사는 사람들은 치킨을 매우 좋아한다. 따라서, 사람들은 "치킨 거리"라는 말을 주로 사용한다. 치킨 거리는 집과 가장 가까운 치킨집 사이의 거리이다. 즉, 치킨 거리는 집을 기준으로 정해지며, 각각의 집은 치킨 거리를 가지고 있다. 도시의 치킨 거리는 모든 집의 치킨 거리의 합이다.
//
//임의의 두 칸 (r1, c1)과 (r2, c2) 사이의 거리는 |r1-r2| + |c1-c2|로 구한다.
//
//예를 들어, 아래와 같은 지도를 갖는 도시를 살펴보자.


//5 3
//0 0 1 0 0
//0 0 2 0 1
//0 1 2 0 0
//0 0 1 0 0
//0 0 0 0 2

import Foundation
final class FileIO {
    private let buffer: Data
    private var index: Int = 0

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        self.buffer = try! fileHandle.readToEnd()! // 인덱스 범위 넘어가는 것 방지
    }

    @inline(__always) private func read() -> UInt8 {
        defer {
            index += 1
        }
        guard index < buffer.count else { return 0 }

        return buffer[index]
    }

    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true

        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }

        return sum * (isPositive ? 1:-1)
    }


    @inline(__always) func readString() -> String {
        var str = ""
        var now = read()

        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시

        while now != 10
                && now != 32 && now != 0 {
            str += String(bytes: [now], encoding: .ascii)!
            now = read()
        }

        return str
    }
}

let FIO = FileIO()
func solution(_ N: Int) -> Int {
    let m = FIO.readInt()
    var board = Array(repeating: Array(repeating: 0, count: N), count: N)
    var houses = [(Int, Int)]()
    var chickens = [(Int, Int)]()
    var combinations = [[Int]]()
    
    for row in 0..<N {
        for col in 0..<N {
            board[row][col] = FIO.readInt()
            if board[row][col] == 1 {
                houses.append((row, col))
            } else if board[row][col] == 2 {
                chickens.append((row, col))
            }
        }
    }
    
    func combination(_ idx: Int, values: [Int]) {
        if values.count == m {
            combinations.append(values)
            return
        }
        
        if idx >= chickens.count {
            return
        }
        
        if values.count + (chickens.count - idx) < m {
            return
        }
        
        combination(idx + 1, values: values)
        var appended = values
        appended.append(idx)
        combination(idx + 1, values: appended)
    }
    if m >= chickens.count {
        combinations = [chickens.enumerated().map { $0.offset }]
    } else {
    combination(0, values: [])
    }
    
    var result = 987654321
    
    for selectedChicken in combinations {
        var total = 0
        for house in houses {
            var minimum = 987654321
            for chicken in selectedChicken {
                let distance = abs(house.0 - chickens[chicken].0) + abs(house.1 - chickens[chicken].1)
                minimum = min(distance, minimum)
            }
            total += minimum
        }
        
        result = min(total, result)
    }
    return result
}

print(solution(FIO.readInt()))


//5 3
//0 0 1 0 0
//0 0 2 0 1
//0 1 2 0 0
//0 0 1 0 0
//0 0 0 0 2
//
//5 1
//2 1 1 1 2
//1 1 1 1 1
//1 1 2 1 1
//1 1 1 1 1
//2 1 1 1 2
