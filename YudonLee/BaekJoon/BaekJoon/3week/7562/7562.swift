import Foundation

final class FileIO {
    private let buffer:[UInt8]
    private var index: Int = 0

    init(fileHandle: FileHandle = FileHandle.standardInput) {

        buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }

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
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
    }

    @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return Array(buffer[beginIndex..<(index-1)])
    }
}
struct Queue<T> {
    var arr:[T] = []
    var front: Int = 0
    var rear: Int = -1
    
    func isEmpty() -> Bool {
        if(front <= rear) {
            return false
        }
        return true
    }
    mutating func push(element: T) {
        arr.append(element)
        rear += 1
    }
    func top() -> T? {
        if(!isEmpty()) {
            return arr[front]
        }
        return nil
    }
    mutating func pop() {
        if(!isEmpty()) {
            front += 1
        }
    }
}

struct Position {
    var row: Int
    var col: Int
    var dist: Int
}

let fio = FileIO()
let testCase = fio.readInt()

let dy = [-1, -2, -2, -1, 1, 2, 2, 1]
let dx = [-2, -1, 1, 2, -2, -1, 1, 2]

for _ in 0..<testCase {
    let N = fio.readInt()
    let startRow = fio.readInt()
    let startCol = fio.readInt()
    let destRow = fio.readInt()
    let destCol = fio.readInt()
    var ans: Int = 0
    
    var visitNode: [[Bool]] = Array(repeating: Array(repeating: false, count: N), count: N)
    var queue = Queue<Position>()
    
    queue.push(element: Position(row: startRow, col: startCol, dist: 0))
    
    while(!queue.isEmpty()) {
        if let t = queue.top() {
            queue.pop()
            if !visitNode[t.row][t.col] {
                visitNode[t.row][t.col] = true
                if t.row == destRow && t.col == destCol {
                    ans = t.dist
                    break;
                }
                for i in 0..<8 {
                    let nextRow = t.row + dy[i]
                    let nextCol = t.col + dx[i]
                    
                    if(0 <= nextRow && nextRow < N && 0 <= nextCol && nextCol < N) {
                        queue.push(element: Position(row: nextRow, col: nextCol, dist: t.dist + 1))
                    }
                }
            }
            
        }
    }
    
    print(ans)
}
