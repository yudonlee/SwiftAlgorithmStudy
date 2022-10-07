//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2022/09/23.
//

import Foundation


func timeToSecond(_ time: Int) -> Int {
    let timeStr = Array(String(format: "%06d", time))
    let second = Int(String(timeStr[4...5]))!
    let minute = Int(String(timeStr[2...3]))!
    let hour = Int(String(timeStr[0...1]))!
    
    return second + minute * 60 + hour * 3600
}

func secondToTime(_ second: Int) -> Int {
    var num = second
    let second = num % 60
    num /= 60
    let minute = num  % 60
    let hour = num / 60
    
    return hour * 10000 + minute * 100 + second
}
func solution(_ play_time:String, _ adv_time:String, _ logs:[String]) -> String {
    
    let playTime = Int(play_time.replacingOccurrences(of: ":", with: ""))!
    let advTime = Int(adv_time.replacingOccurrences(of: ":", with: ""))!
    
    let playTimeSecond = timeToSecond(playTime)
    let advTimeSecond = timeToSecond(advTime)
    
    var arr = Array(repeating: 0, count: 360001)
    var prefixSum: [Int64] = Array(repeating: 0, count: 360001)
    
    logs.forEach { query in
        let range = query.replacingOccurrences(of: ":", with: "").components(separatedBy: "-")
        let start = Int(range[0])!
        let startSecond = timeToSecond(start)
        let end = Int(range[1])!
        let endSecond = timeToSecond(end)
        arr[startSecond] += 1
        arr[endSecond] -= 1
    }
    
    prefixSum[0] = Int64(arr[0])
    for idx in 1...playTimeSecond {
        prefixSum[idx] = prefixSum[idx - 1] + Int64(arr[idx])
    }
    for idx in 1...playTimeSecond {
        prefixSum[idx] += prefixSum[idx - 1]
    }
    
    
    var count = 0
    var maxSum: Int64 = prefixSum[advTimeSecond - 1]
    
    var start = 0
    
    for idx in stride(from: 1, through: playTimeSecond - advTimeSecond + 1, by: +1) {
        let sum: Int64 = prefixSum[idx + advTimeSecond - 1] - prefixSum[idx - 1]
        if sum > maxSum {
            maxSum = sum
            start = idx
        }
    }
    let result = Array(String(format: "%06d", secondToTime(start)))
    let data = result[0...1] + ":" + result[2...3] + ":" + result[4...5]
    
    return String(data)
}

print(solution("02:03:55", "00:14:15", ["01:20:15-01:45:14", "00:25:50-00:48:29", "00:40:31-01:00:00", "01:37:44-02:02:30", "01:30:59-01:53:29"]))


print(solution("99:59:59", "25:00:00", ["69:59:59-89:59:59", "01:00:00-21:00:00", "79:59:59-99:59:59", "11:00:00-31:00:00"]))

print(solution("50:00:00", "50:00:00", ["15:36:51-38:21:49", "10:14:18-15:36:51", "38:21:49-42:51:45"]))

