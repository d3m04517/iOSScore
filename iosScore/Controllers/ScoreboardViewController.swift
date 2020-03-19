//
//  ScoreboardViewController.swift
//  iosScore
//
//  Created by Lewis Kim on 2020-03-04.
//  Copyright © 2020 Lewis Kim. All rights reserved.
//

import UIKit

class ScoreboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let networkingService = NetworkingService()
    
    private var date = Date()
    private var searchDateString = ""
    
    private var gamesAPIData: GamesAPI? {
        didSet {
            if let gameData = gamesAPIData {
                for index in 0..<gameData.api.games.count {
                    let hTeamId = gameData.api.games[index].hTeam.teamId
                    let vTeamId = gameData.api.games[index].vTeam.teamId
                    
                    // Get statistics
                    networkingService.getStatsForGame(at: gameData.api.games[index].gameId) {[weak self] result in
                        switch result {
                        case .success(let results):
                            self?.statisticsAPI += [results.api]
                            if self?.statisticsAPI.count == gameData.api.games.count, self?.hStandingsAPI.count == gameData.api.games.count, self?.vStandingsAPI.count == gameData.api.games.count {
                                self?.scoreboardTableView.reloadData()
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                    
                    // Get standings
                    networkingService.getStandingForId(at: hTeamId) {[weak self] result in
                        switch result {
                        case .success(let results):
                            self?.cellOpened += [false]
                            self?.hStandingsAPI += [results.api.standings[0]]
                            //print(self?.statisticsAPI.count, gameData.api.games.count, self?.hStandingsAPI.count, self?.vStandingsAPI.count)
                            if self?.statisticsAPI.count == gameData.api.games.count, self?.hStandingsAPI.count == gameData.api.games.count, self?.vStandingsAPI.count == gameData.api.games.count {
                                DispatchQueue.main.async {
                                    self?.scoreboardTableView.reloadData()
                                }
                            }
                        case .failure(let error):
                            print(error)
                            
                        }
                    }
                    
                    networkingService.getStandingForId(at: vTeamId) {[weak self] result in
                        switch result {
                        case .success(let results):
                            self?.cellOpened += [false]
                            self?.vStandingsAPI += [results.api.standings[0]]
                            //print(self?.statisticsAPI.count, gameData.api.games.count, self?.hStandingsAPI.count, self?.vStandingsAPI.count)
                            if self?.statisticsAPI.count == gameData.api.games.count, self?.hStandingsAPI.count == gameData.api.games.count, self?.vStandingsAPI.count == gameData.api.games.count {
                                DispatchQueue.main.async {
                                    self?.scoreboardTableView.reloadData()
                                }
                            }
                        case .failure(let error):
                            print(error)
                            
                        }
                    }
                }
            }
        }
    }
    
    private var statisticsAPI = [StatsResults]()
    private var hStandingsAPI = [Standing]()
    private var vStandingsAPI = [Standing]()
    private var cellOpened = [Bool]()
    
    // Date navigation button outlets
    @IBOutlet weak var navigateBeforeButton: UIButton!
    
    @IBOutlet weak var navigateAfterButton: UIButton!
    
    @IBAction func tapNavigateBeforeButton(_ sender: UIButton) {
        if let dayAfter = Calendar.current.date(byAdding: .day, value: -1, to: date) {
            date = dayAfter
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, MMM d"
            
            let dateString = dateFormatter.string(from: dayAfter)
            dateTitleLabel.text = dateString
            dateTitleLabel.sizeToFit()
            searchDateString = formatDate(date: date)
            reloadData()
        }
    }
    @IBAction func tapNavigateAfterButton(_ sender: UIButton) {
        if let dayAfter = Calendar.current.date(byAdding: .day, value: 1, to: date) {
            date = dayAfter
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, MMM d"
            
            let dateString = dateFormatter.string(from: dayAfter)
            dateTitleLabel.text = dateString
            dateTitleLabel.sizeToFit()
            searchDateString = formatDate(date: date)
            reloadData()
        }
    }
    
    @IBOutlet weak var scoreboardTableView: UITableView!
    
    @IBOutlet weak var dateTitleLabel: UILabel! {
        didSet {
            let currentDate = Date()
            if date == currentDate {
                dateTitleLabel.text = "today"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchDateString = formatDate(date: date)
        networkingService.getGamesForDate(at: searchDateString) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let results):
                self?.gamesAPIData = results
                
            }
        }
        scoreboardTableView.rowHeight = view.bounds.height / 4
        setNavBtnTemplate()
        scoreboardTableView.delegate = self
        scoreboardTableView.dataSource = self
    }
    
    // Table View delegate functions
    func numberOfSections(in tableView: UITableView) -> Int {
        if let api = gamesAPIData, retrievingDataComplete() {
            return api.api.games.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellOpened.count != 0, retrievingDataComplete() {
            
            if !cellOpened[section] {
                return 1
            } else {
                return 2
            }
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0, retrievingDataComplete() {
            let cell = scoreboardTableView.dequeueReusableCell(withIdentifier: "Game Cell") as! ScoreboardTableViewCell
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowRadius = 5
            
            cell.layer.shadowOpacity = 0.40
            cell.clipsToBounds = false;
            if let gamesApi = gamesAPIData {
                cell.game = gamesApi.api.games[indexPath.section]
                
                if hStandingsAPI.count == gamesApi.api.games.count, vStandingsAPI.count == gamesApi.api.games.count {
                    cell.hStanding = hStandingsAPI[indexPath.section]
                    cell.vStanding = vStandingsAPI[indexPath.section]
                }
            }
            
            return cell
        } else if retrievingDataComplete() {
            let cell = scoreboardTableView.dequeueReusableCell(withIdentifier: "Stats Cell", for: indexPath) as! GameStatsTableViewCell
            if let gamesApi = gamesAPIData {
                let hFullTeamName = gamesApi.api.games[indexPath.section].hTeam.fullName
                let vFullTeamName = gamesApi.api.games[indexPath.section].vTeam.fullName
                let hLogoFileName = hFullTeamName.lowercased().replacingOccurrences(of: " ", with: "-")
                let vLogoFileName = vFullTeamName.lowercased().replacingOccurrences(of: " ", with: "-")
                cell.hLogoImageView.image =  UIImage(named: "\(hLogoFileName)-logo-transparent")
                cell.vLogoImageView.image =  UIImage(named: "\(vLogoFileName)-logo-transparent")
                cell.matchupLabel.text = ("\(gamesApi.api.games[indexPath.section].hTeam.nickName) v. \(gamesApi.api.games[indexPath.section].vTeam.nickName)")
                cell.arenaLabel.text = gamesApi.api.games[indexPath.section].arena
                cell.dateLabel.text = searchDateString
                cell.statistics = statisticsAPI[indexPath.section]
                cell.backgroundColor = #colorLiteral(red: 0.9518935686, green: 0.9518935686, blue: 0.9518935686, alpha: 1)
                cell.frame.size.height = 600
                return cell
            } else {
                return UITableViewCell()
            }
        }
        else {
            let cell = scoreboardTableView.dequeueReusableCell(withIdentifier: "Loading Cell") as! LoadingTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if cellOpened[indexPath.section], retrievingDataComplete() {
            cellOpened[indexPath.section] = false
            let sections = IndexSet(integer: indexPath.section)
            scoreboardTableView.reloadSections(sections, with: .none)
        } else if retrievingDataComplete() {
            cellOpened[indexPath.section] = true
            let sections = IndexSet(integer: indexPath.section)
            scoreboardTableView.reloadSections(sections, with: .none)
        }
        
    }
    
    // Renders image and sets tint color of date nav buttons.
    private func setNavBtnTemplate() {
        navigateBeforeButton.setImage(UIImage(named: "navigate_before")?.withRenderingMode(.alwaysTemplate), for: .normal)
        navigateAfterButton.setImage(UIImage(named: "navigate_after")?.withRenderingMode(.alwaysTemplate), for: .normal)
        navigateBeforeButton.tintColor = UIColor.black
        navigateAfterButton.tintColor = UIColor.black
    }
    
    private func retrievingDataComplete() -> Bool {
        if gamesAPIData != nil {
            if hStandingsAPI.count == gamesAPIData?.api.games.count, statisticsAPI.count == gamesAPIData?.api.games.count {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    private func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    private func reloadData() {
        gamesAPIData = nil
        hStandingsAPI = []
        vStandingsAPI = []
        statisticsAPI = []
        scoreboardTableView.reloadData()
        networkingService.getGamesForDate(at: searchDateString) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let results):
                self?.gamesAPIData = results
                
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension ScoreboardViewController {
    struct Size {
        static let navigationButtonSize = CGSize(width: 50, height: 50)
    }
}
