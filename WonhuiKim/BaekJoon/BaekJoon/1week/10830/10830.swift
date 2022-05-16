//
//10830.swift
//  BaekJoon
//
//  Created by 김원희 on 2022/05/10.
//

/*
 크기가 N*N인 행렬 A가 주어진다. 이때, A의 B제곱을 구하는 프로그램을 작성하시오. 수가 매우 커질 수 있으니, A^B의 각 원소를 1,000으로 나눈 나머지를 출력한다.
 
 첫째 줄에 행렬의 크기 N과 B가 주어진다. (2 ≤ N ≤  5, 1 ≤ B ≤ 100,000,000,000)

 둘째 줄부터 N개의 줄에 행렬의 각 원소가 주어진다. 행렬의 각 원소는 1,000보다 작거나 같은 자연수 또는 0이다.
 */

import Foundation

let input = readLine()!.split(separator: " ").map{ Int(String($0))! }
let N = input[0] //행렬 크기
let B = input[1] //제곱

var arr: [[Int]] = Array(repeating: Array(repeating: 0, count: N), count: N)

for i in 0..<N { //행렬에 데이터 삽입
    arr[i] = readLine()!.split(separator: " ").map{ Int(String($0))! }
}








