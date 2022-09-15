//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2022/09/15.
//

import Foundation

//["muzi", "frodo", "apeach", "neo"], ["muzi frodo", "apeach frodo", "frodo neo", "muzi neo", "apeach muzi"], 2

struct Report {
    let reporter: String
    let badUser: String
}

func solution(_ id_list:[String], _ report:[String], _ k:Int) -> [Int] {
    
    var reportedList: [String: Set<String>] = [:]
    var reportingList: [String: Set<String>] = [:]
    
    report.forEach { str in
        let data = str.split(separator: " ").map{ String($0) }
        let userReport = Report(reporter: data[0], badUser: data[1])
        
        if reportedList[userReport.badUser] == nil {
            reportedList[userReport.badUser] = [userReport.reporter]
        } else {
            reportedList[userReport.badUser]?.update(with: userReport.reporter)
        }
        
        if reportingList[userReport.reporter] == nil {
            reportingList[userReport.reporter] = [userReport.badUser]
        } else {
            reportingList[userReport.reporter]?.update(with: userReport.badUser)
        }
        
    }

    var reportedCount: [String: Int] = [:]
    id_list.forEach { id in
        if reportedList[id] == nil {
            reportedCount.updateValue(0, forKey: id)
        } else {
            reportedCount.updateValue(reportedList[id]?.count ?? 0, forKey: id)
        }
    }
    
    let result: [Int] = id_list.map { id in
        var count = 0
        reportingList[id]?.forEach({ badUser in
            if let blockedCount = reportedCount[badUser], blockedCount >= k {
                count += 1
            }
        })
        return count
    }

//    print(result)
    
    
    return result
}

solution(    ["con", "ryan", "muzi", "frodo", "apeach", "neo"], ["ryan con", "ryan con", "ryan con", "ryan con", "muzi frodo", "apeach frodo", "frodo neo", "muzi neo", "apeach muzi", "muzi con"], 2)
