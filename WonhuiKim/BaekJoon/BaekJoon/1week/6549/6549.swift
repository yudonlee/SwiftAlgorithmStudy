//
//  6549.swift
//  BaekJoon
//
//  Created by 김원희 on 2022/05/10.
//

/*
 히스토그램은 직사각형 여러 개가 아래쪽으로 정렬되어 있는 도형이다. 각 직사각형은 같은 너비를 가지고 있지만, 높이는 서로 다를 수도 있다. 예를 들어, 왼쪽 그림은 높이가 2, 1, 4, 5, 1, 3, 3이고 너비가 1인 직사각형으로 이루어진 히스토그램이다.
 
 히스토그램에서 가장 넓이가 큰 직사각형을 구하는 프로그램을 작성하시오.
 
 입력은 테스트 케이스 여러 개로 이루어져 있다. 각 테스트 케이스는 한 줄로 이루어져 있고, 직사각형의 수 n이 가장 처음으로 주어진다. (1 ≤ n ≤ 100,000) 그 다음 n개의 정수 h1, ..., hn (0 ≤ hi ≤ 1,000,000,000)가 주어진다. 이 숫자들은 히스토그램에 있는 직사각형의 높이이며, 왼쪽부터 오른쪽까지 순서대로 주어진다. 모든 직사각형의 너비는 1이고, 입력의 마지막 줄에는 0이 하나 주어진다.
 
 
 */

import Foundation

var input = [-1]

//repeat {
//    input = readLine()!.split(separator: " ").map{ Int(String($0))!}
//    print(input)
//} while input[0] != 0

while true { //input에 값이 하나이고, 그 값이 0이면 중단. input에 값이 여러개이거나, 그 값이 0이 아니면 계속.
    input = readLine()!.split(separator: " ").map{ Int(String($0))!}
    
    if input.count == 1 && input[0] == 0 {
        break
    }
    
    input.sort() //오름차순 정렬?

    let start = input[0]
    let end = input[input.count-1]
    let mid = input[(start+end)/2]
    print("\(start), \(end), \(mid)")
}

