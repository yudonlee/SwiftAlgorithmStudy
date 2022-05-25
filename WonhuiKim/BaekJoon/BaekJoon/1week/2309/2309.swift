//
//  main.swift
//  BaekJoon
//
//  Created by 김원희 on 2022/05/07.
//

import Foundation

var intArr = [Int]()
var cnt: Int = 0

for _ in 0..<9 {
    let input = Int(readLine()!)
    intArr.append(input!) //입력받은 정수를 배열에 삽입
    cnt += input! //입력받은 정수 총합 계산
}

cnt -= 100 //입력받은 정수 총합 - 100

outerRoop: for i in 0..<8 {
    for j in i+1..<9 {
        if intArr[i] + intArr[j] == cnt { //키의 합이 cnt인 두 명 찾기
            intArr[i] = 0
            intArr[j] = 0 //값을 0으로 변경해줌
            
            break outerRoop
        }
    }
}

intArr.sort() //오름차순 정렬

for i in 2..<9 { //두 명의 키를 0으로 수정 > 오름차순 정렬했으므로 앞에 2개 빼고 출력
    print(intArr[i])
}

