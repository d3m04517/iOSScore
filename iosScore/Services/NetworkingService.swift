//
//  NetworkingService.swift
//  iosScore
//
//  Created by Lewis Kim on 2020-03-04.
//  Copyright © 2020 Lewis Kim. All rights reserved.
//

import Foundation

struct NetworkingService {
    
    let resourceUrl = "https://api-nba-v1.p.rapidapi.com"
    let headers = [
        "x-rapidapi-host": "api-nba-v1.p.rapidapi.com",
        "x-rapidapi-key": ""
    ]
    
    //
    func getGamesForDate(at date: String, completion: @escaping(Result<GamesAPI, Error>) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: "\(resourceUrl)/games/date/\(date)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        print(date)
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest) { data,_,error in
            guard let jsonData = data else {
                completion(.failure(error!))
                return
            }
            do {
                let decoder = JSONDecoder()
                
                let gameResponse = try decoder.decode(GamesAPI.self, from: jsonData)
                completion(.success(gameResponse))
            } catch {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
    
    func getStandingForId(at teamId: String, completion: @escaping(Result<StandingsAPI, Error>) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: "\(resourceUrl)/standings/standard/2019/teamId/\(teamId)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let dataTask = URLSession.shared.dataTask(with: request as URLRequest) { data,_,error in
            guard let jsonData = data else {
                completion(.failure(error!))
                return
            }
            do {
                let decoder = JSONDecoder()
                let standingsResponse = try decoder.decode(StandingsAPI.self, from: jsonData)
                completion(.success(standingsResponse))
            } catch {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
    
    func getStatsForGame(at gameId: String, completion: @escaping(Result<Statistics, Error>) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: "\(resourceUrl)/statistics/games/gameId/\(gameId)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest) { data,_,error in
            guard let jsonData = data else {
                completion(.failure(error!))
                return
            }
            do {
                let decoder = JSONDecoder()
                let statisticsResponse = try decoder.decode(Statistics.self, from: jsonData)
                completion(.success(statisticsResponse))
            } catch {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
}
