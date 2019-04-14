//
//  Score.swift
//  guessWhat_T12
//
//  Created by Harry Archer on 2019-04-12.
//  Copyright © 2019 T12. All rights reserved.
//
import Foundation
class Score{
    var id: Int
    var username: String
    var score: Int
    
    init(id: Int, username: String, score: Int) {
        self.id = id
        self.username = username
        self.score = score
    }
}
