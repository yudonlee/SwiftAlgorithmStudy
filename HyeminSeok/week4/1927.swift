//
//  main.swift
//  BackJoon
//
//  Created by Lena on 2022/05/25.
// 1927번

import Foundation

struct MinHeap<T:Comparable> {
    var heap: [T] = []
    
    var isEmpty: Bool {
        return heap.count <= 1 ? true : false
    }
    
    init() {}
    init(_ element: T) {
        heap.append(element) // 0번 인덱스 채우기
        heap.append(element) // root node 들어간다
    }
    
    mutating func insert(_ element: T) {
        if heap.isEmpty {
            heap.append(element)
            heap.append(element)
            return
        }
        heap.append(element)
        
        func isMoveUp(_ insertIndex: Int) -> Bool {
            if insertIndex <= 1 {
                return false
            }
            let parentIndex = insertIndex / 2
            return heap[insertIndex] < heap[parentIndex] ? true : false
        }
        
        var insertIndex = heap.count - 1
        while isMoveUp(insertIndex) {
            let parentIndex = insertIndex / 2 // 부모노드
            heap.swapAt(insertIndex, parentIndex) // 자리 바꿈
            insertIndex = parentIndex
        }
    }
    
    enum moveDownStatus {
        case left
        case right
        case none
    }
    
    mutating func pop() -> T? {
        if heap.count <= 1 {
            return nil
        }
        
        let returnData = heap[1]
        heap.swapAt(1, heap.count - 1)
        heap.removeLast()
        
        func moveDown(_ poppedIndex: Int) -> moveDownStatus {
            let leftChildIndex = poppedIndex * 2
            let rightChildIndex = leftChildIndex + 1
            
            // 모든 자식노드가 없는 경우 (왼쪽)
            if leftChildIndex >= heap.count {
                return .none
            }
            
            // 왼쪽 자식 노드만 있는 경우
            if rightChildIndex >= heap.count {
                return heap[leftChildIndex] < heap[poppedIndex] ? .left : .none
            }
            
            // 왼쪽 & 오른쪽 자식 노드 모두 있는 경우
            ////   부모노드가 작은 경우
            if (heap[leftChildIndex] > heap[poppedIndex]) && (heap[rightChildIndex] > heap[poppedIndex]) {
                return .none
            }
            
            //// 자식들이 부모보다 모두 작은 경우 (왼쪽, 오른쪽 자식 중 더 작은 노드 선별)
            if (heap[leftChildIndex] < heap[poppedIndex]) && (heap[rightChildIndex] < heap[poppedIndex]) {
                return heap[leftChildIndex] < heap[rightChildIndex] ? .left : .right
            }
            
            //  왼쪽 오른쪽 자식 중 한 노드만 부모보다 작은 경우
            if (heap[leftChildIndex] < heap[poppedIndex] || (heap[rightChildIndex] < heap[poppedIndex])) {
                return heap[leftChildIndex] < heap[rightChildIndex] ? .left : .right
            }
            return .none
        }
        
        var poppedIndex = 1 // 1부터 시작
        while true {
            switch moveDown(poppedIndex) {
            case .none:
                return returnData
            case .left:
                let leftChildIndex = poppedIndex * 2
                heap.swapAt(poppedIndex, leftChildIndex)
                poppedIndex = leftChildIndex
            case .right:
                let rightChildIndex = (poppedIndex * 2) + 1
                heap.swapAt(poppedIndex, rightChildIndex)
                poppedIndex = rightChildIndex
            }
        }
    }
}

let n = Int(readLine()!)!
var minHeap: MinHeap<Int> = MinHeap() // 인스턴스 생성

for _ in 0..<n {
    let input = Int(readLine()!)!
    
    if input == 0 {
        let answer = minHeap.pop()
        answer == nil ? print("0") : print(answer!)
    }
    else {
        minHeap.insert(input)
    }
}


