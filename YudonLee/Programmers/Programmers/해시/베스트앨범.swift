//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2022/10/06.
//

import Foundation

struct Song {
    var play: Int
    var index: Int
}
func solution(_ genres:[String], _ plays:[Int]) -> [Int] {
    let genresSet = Set(genres)
    var genreTopTwo: [String: [Song]] = [:]
    genresSet.forEach { idx in
        genreTopTwo.updateValue([Song(play: 0, index: -1), Song(play: 0, index: -1)], forKey: idx)
    }
    
    var genrePlayCount: [String: Int] = [:]
    
//    장르 카운트 반영
    for idx in 0..<genres.count {
        if genrePlayCount[genres[idx]] == nil {
            genrePlayCount[genres[idx]] = plays[idx]
        } else {
            genrePlayCount[genres[idx]]! += plays[idx]
        }
        
        let current = genreTopTwo[genres[idx]]!
        
        if current.first!.play < plays[idx] || (current.first!.play == plays[idx] && current.first!.index > idx) {
            genreTopTwo[genres[idx]]![1] = current.first!
            genreTopTwo[genres[idx]]![0] = Song(play: plays[idx], index: idx)
        } else {
            if current.last!.play < plays[idx] || (current.last!.play == plays[idx] && current.last!.index > idx) {
                genreTopTwo[genres[idx]]![1] = Song(play: plays[idx], index: idx)
            }
        }
    }
    var sortedGenre = genrePlayCount.sorted { leftGenre,  rightGenre in
        leftGenre.value > rightGenre.value
    }
    
    var result: [Int] = []
    sortedGenre.forEach { genre in
        let song = genreTopTwo[genre.key]!
        if song.last!.index != -1 {
            result += [song.first!.index, song.last!.index]
        } else {
            result += [song.first!.index]
        }
    }
    
    return result
    
    
}

print(solution(["classic", "pop", "classic", "classic", "pop", "opera"], [500, 600, 150, 800, 2500, 4000]))

print(solution(["classic", "pop", "classic", "classic", "pop", "opera", "classsic", "popd", "clasasic", "clfassic", "pcop", "opesra"], [500, 600, 150, 800, 2500, 4000, 50, 60, 15, 80, 250, 400]))
