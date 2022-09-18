//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2022/09/16.
//

import Foundation

var possibleMenu: [String] = []

func makePossibleMenu(_ menu: [Character], _ course: String,_ idx: Int, _ n: Int) {
    course.combinations(ofCount: 3)
    if course.count == n {
        possibleMenu.append(course)
        return
    }
    
    if idx < menu.count {
        let newCourse = course + String(menu[idx])
        makePossibleMenu(menu, newCourse, idx + 1, n)
        makePossibleMenu(menu, course, idx + 1, n)
    }
}

func solution(_ orders:[String], _ course:[Int]) -> [String] {
    var counts: [String: Int] = [:]
    var result: [String] = []
    var maxCount: [Int] = Array(repeating: 0, count: 11)
    possibleMenu = []
    
    orders.forEach { dishes in
        
        let menu: [Character] = dishes.sorted()
        course.forEach { n in
            makePossibleMenu(menu, "", 0, n)
        }
    }
    
    possibleMenu.forEach { courseMenu in
        if counts[courseMenu] == nil {
            counts[courseMenu] = 1
        } else {
            counts[courseMenu]! += 1
        }
        
        if counts[courseMenu] == 2, course.contains(courseMenu.count) {
            result.append(courseMenu)
        }
        
        if maxCount[courseMenu.count] < counts[courseMenu]! {
            maxCount[courseMenu.count] = counts[courseMenu]!
        }
    }
    
    result = result.filter { menu in
        return maxCount[menu.count] == counts[menu] ? true : false
    }
    return result.sorted()
}

print(solution(["ABCFG", "AC", "CDE", "ACDE", "BCFG", "ACDEH"], [2, 3, 4]))
print(solution(["ABCDE", "AB", "CD", "ADE", "XYZ", "XYZ", "ACD"], [2, 3, 5]))
print(solution(    ["XYZ", "XWY", "WXA"], [2, 3, 4]))



