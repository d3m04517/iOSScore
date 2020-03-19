//
//  BasketballGame.swift
//  iosScore
//
//  Created by Lewis Kim on 2020-03-04.
//  Copyright © 2020 Lewis Kim. All rights reserved.
//

import Foundation

// Game general information

struct GamesAPI: Decodable {
    var api: GameResults
}

struct GameResults: Decodable {
    var status: Int
    var message: String
    var results: Int
    var filters: [String]
    var games: [Game]
}

struct Game: Decodable {
    var seasonYear: String
    var league: String
    var gameId: String
    var startTimeUTC: String
    var endTimeUTC: String
    var arena: String
    var city: String
    var country: String
    var clock: String
    var gameDuration: String
    var currentPeriod: String
    var halftime: String
    var EndOfPeriod: String
    var seasonStage: String
    var statusShortGame: String
    var statusGame: String
    var vTeam: Team
    var hTeam: Team
}

struct Team: Decodable {
    var teamId: String
    var shortName: String
    var fullName: String
    var nickName: String
    var logo: String
    var score: Score
}

struct Score: Decodable {
    var points: String
}

// Game statistics
struct Statistics: Decodable {
    var api: StatsResults
}

struct StatsResults: Decodable {
    var status: Int
    var message: String
    var results: Int
    var filters: [String]
    var statistics: [TeamStats]
}

struct TeamStats: Decodable {
    var gameId: String
    var teamId: String
    var fastBreakPoints: String
    var pointsInPaint: String
    var biggestLead: String
    var secondChancePoints: String
    var pointsOffTurnovers: String
    var longestRun: String
    var points: String
    var fgm: String
    var fga: String
    var fgp: String
    var ftm: String
    var fta: String
    var ftp: String
    var tpm: String
    var tpa: String
    var tpp: String
    var offReb: String
    var defReb: String
    var totReb: String
    var assists: String
    var pFouls: String
    var steals: String
    var turnovers: String
    var blocks: String
    var plusMinus: String
    var min: String
}
