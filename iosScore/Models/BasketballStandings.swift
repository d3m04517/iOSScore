//
//  BasketballStandings.swift
//  iosScore
//
//  Created by Lewis Kim on 2020-03-04.
//  Copyright © 2020 Lewis Kim. All rights reserved.
//

import Foundation

struct StandingsAPI: Decodable {
    var api: Standings
}

struct Standings: Decodable {
    var status: Int
    var message: String
    var results: Int
    var filters: [String]
    var standings: [Standing]
}

struct Standing: Decodable {
    var league: String
    var teamId: String
    var win: String
    var loss: String
    var gamesBehind: String
    var lastTenWin: String
    var lastTenLoss: String
    var streak: String
    var seasonYear: String
    var conference: Conference
    var division: Division
    var winPercentage: String
    var lossPercentage: String
    var home: Advantage
    var away: Advantage
    var winStreak: String
    var tieBreakerPoints: String
}

struct Conference: Decodable {
    var name: String
    var rank: String
    var win: String
    var loss: String
}

struct Division: Decodable {
    var name: String
    var rank: String
    var win: String
    var loss: String
    var GamesBehind: String
}

struct Advantage: Decodable {
    var win: String
    var loss: String
}

