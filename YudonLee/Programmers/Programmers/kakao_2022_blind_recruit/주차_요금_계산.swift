//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2022/09/14.
//

import Foundation

// [180, 5000, 10, 600], ["05:34 5961 IN", "06:00 0000 IN", "06:34 0000 OUT", "07:59 5961 OUT", "07:59 0148 IN", "18:59 0000 IN", "19:09 0148 OUT", "22:59 5961 IN", "23:00 5961 OUT"]


struct Time {
    let hour: Int
    let minute: Int
}

struct Parking {
    let carNumber: Int
    let type: Bool
    let time: Time
}
func calculate(inTime: Time, outTime: Time) -> Int {
    let hourTime = outTime.hour - inTime.hour
    let minTime = outTime.minute - inTime.minute
    return hourTime * 60 + minTime
}
func solution(_ fees:[Int], _ records:[String]) -> [Int] {
    var cars: [Time] = Array(repeating: Time(hour: -1, minute: -1), count: 10000)
    var accumulatedTime: [Int] = Array(repeating: 0, count: 10000)
    var carList: [Int] = []
    
    let parkedRecord = records.map { record  -> Parking in
        let parsed = record.components(separatedBy: " ")
        let totalTime = parsed[0].split(separator: ":").map { time in
            return Int(time)!
        }
        let parsedTime = Time(hour: totalTime[0], minute: totalTime[1])
        return Parking(carNumber: Int(parsed[1])!, type: parsed[2] == "IN", time: parsedTime)
    }

    parkedRecord.forEach { parking in
        if !carList.contains(parking.carNumber) {
            carList.append(parking.carNumber)
        }
        if parking.type {
            cars[parking.carNumber] = parking.time
        } else {
            let parkedTime = calculate(inTime: cars[parking.carNumber], outTime: parking.time)
            accumulatedTime[parking.carNumber] += parkedTime
            cars[parking.carNumber] = Time(hour: -1, minute: -1)
        }
    }
    
    var result: [Int] = []
    carList.sort()
    carList.forEach { carNumber in
        if cars[carNumber].hour != -1 {
            let parkedTime = calculate(inTime: cars[carNumber], outTime: Time(hour: 23, minute: 59))
            accumulatedTime[carNumber] += parkedTime
            cars[carNumber] = Time(hour: -1, minute: -1)
        }
        
        print(carNumber, accumulatedTime[carNumber])
        
        if accumulatedTime[carNumber] < fees[0] {
            result.append(fees[1])
        } else {
            let remainedTime = accumulatedTime[carNumber] - fees[0]
            var units = Int(remainedTime / fees[2])
            units += remainedTime % fees[2] > 0 ? 1 : 0
            result.append(fees[1] + units * fees[3])
        }
    }
    return result
}


print("sol1")
solution([180, 5000, 10, 600], ["05:34 5961 IN", "06:00 0000 IN", "06:34 0000 OUT", "07:59 5961 OUT", "07:59 0148 IN", "18:59 0000 IN", "19:09 0148 OUT", "22:59 5961 IN", "23:00 5961 OUT", "16:00 3950 IN", "16:00 3320 IN", "18:00 3950 OUT", "18:00 3320 OUT", "23:58 2211 IN"])

print("sol2")
solution([120, 100, 60, 591], ["16:00 3950 IN", "16:00 3320 IN", "18:00 3950 OUT", "18:00 3320 OUT", "23:58 2211 IN"])
