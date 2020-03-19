//
//  ScoreboardTableViewCell.swift
//  iosScore
//
//  Created by Lewis Kim on 2020-03-08.
//  Copyright © 2020 Lewis Kim. All rights reserved.
//

import UIKit

class ScoreboardTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization cod
    }
    
    var isOpened = false
    
    let networking = NetworkingService()
    
    @IBOutlet weak var homeImageView: UIImageView!
    @IBOutlet weak var homeNameLabel: UILabel!
    @IBOutlet weak var homeStandingsLabel: UILabel!
    
    @IBOutlet weak var awayImageView: UIImageView!
    @IBOutlet weak var awayNameLabel: UILabel!
    @IBOutlet weak var awayStandingsLabel: UILabel!
    
    @IBOutlet weak var gameScoreLabel: UILabel!
    
    var hStanding: Standing? {
        didSet {
            if let standing = hStanding {
                homeStandingsLabel.text = "\(standing.win)-\(standing.loss)"
                homeStandingsLabel.sizeToFit()
            }
        }
    }
    var vStanding: Standing? {
        didSet {
            if let standing = vStanding {
                    awayStandingsLabel.text = "\(standing.win)-\(standing.loss)"
                awayStandingsLabel.sizeToFit()
            }
        }
    }
    
    var game: Game? {
        didSet {
            // Get file name through full name of team
            if let gameData = self.game {
                let hFullTeamName = gameData.hTeam.fullName
                let vFullTeamName = gameData.vTeam.fullName
                
                let hLogoFile = (((hFullTeamName.lowercased()).replacingOccurrences(of: " ", with: "-"))) + "-logo-transparent"
                let vLogoFile = (((vFullTeamName.lowercased()).replacingOccurrences(of: " ", with: "-"))) + "-logo-transparent"
                homeImageView.image = UIImage(named: hLogoFile)?.withRenderingMode(.alwaysOriginal)
                awayImageView.image = UIImage(named: vLogoFile)?.withRenderingMode(.alwaysOriginal)
                // Set labels
                homeNameLabel.text = gameData.hTeam.nickName
                awayNameLabel.text = gameData.vTeam.nickName
                gameScoreLabel.text = "\(gameData.hTeam.score.points) - \(gameData.vTeam.score.points)"
                gameScoreLabel.sizeToFit()
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
