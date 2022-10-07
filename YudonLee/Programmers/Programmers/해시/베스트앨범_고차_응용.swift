//
//  main.swift
//  Programmers
//
//  Created by yudonlee on 2022/10/07.
//

import Foundation

struct Song {
    var play: Int
    var index: Int
}
func solution(_ genres:[String], _ plays:[Int]) -> [Int] {
    var genreList: [String: (play: Int, music: [Int: Int])] = [:]
    var result: [Int] = []
 
    
        
    for (idx, genre) in genres.enumerated() {
        if let accumulatedGenre = genreList[genre] {
            genreList[genre]!.play = accumulatedGenre.play + plays[idx]
            genreList[genre]!.music.updateValue(plays[idx], forKey: idx)
        } else {
            genreList[genre] = (plays[idx], [idx: plays[idx]])
        }
    }
    
    let rank = genreList.sorted { $0.value.play > $1.value.play }
    
    rank.forEach { genre in
        let songList = genre.value.music.sorted { $0.key < $1.key }.sorted { $0.value > $1.value }
        
        let songCount = songList.count > 1 ? 2 : 1
        
        for idx in 0..<songCount {
            result.append(songList[idx].key)
        }
    }
    return result
}


print(solution(["classic", "pop", "classic", "classic", "pop"], [500, 600, 150, 800, 2500]))
print(solution(["classic", "pop", "classic", "classic", "pop", "opera"], [500, 600, 150, 800, 2500, 4000]))

print(solution(["classic", "pop", "classic", "classic", "pop", "opera", "classsic", "popd", "clasasic", "clfassic", "pcop", "opesra"], [500, 600, 150, 800, 2500, 4000, 50, 60, 15, 80, 250, 400]))

