//
//  GameStatsTableViewCell.swift
//  iosScore
//
//  Created by Lewis Kim on 2020-03-10.
//  Copyright © 2020 Lewis Kim. All rights reserved.
//

import UIKit

class GameStatsTableViewCell: UITableViewCell {
    
    private var sizeRatio: CGFloat = 1.5
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    @IBOutlet weak var statsLabelView: UIView!
    @IBOutlet weak var matchupLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var arenaLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
    
    // Home team stats labels
    @IBOutlet weak var hPointsLabel: UILabel!
    @IBOutlet weak var hFGLabel: UILabel!
    @IBOutlet weak var h3PLabel: UILabel!
    @IBOutlet weak var hFTLabel: UILabel!
    @IBOutlet weak var hReboundLabel: UILabel!
    @IBOutlet weak var hAssistsLabel: UILabel!
    @IBOutlet weak var hBlocksLabel: UILabel!
    @IBOutlet weak var hFoulsLabel: UILabel!
    @IBOutlet weak var hStealsLabel: UILabel!
    @IBOutlet weak var hTurnoversLabel: UILabel!
    @IBOutlet weak var hLogoImageView: UIImageView!
    
    // Away team stats labels
    @IBOutlet weak var vPointsLabel: UILabel!
    @IBOutlet weak var vFGLabel: UILabel!
    @IBOutlet weak var v3PLabel: UILabel!
    @IBOutlet weak var vFTLabel: UILabel!
    @IBOutlet weak var vReboundLabel: UILabel!
    @IBOutlet weak var vAssistsLabel: UILabel!
    @IBOutlet weak var vBlocksLabel: UILabel!
    @IBOutlet weak var vFoulsLabel: UILabel!
    @IBOutlet weak var vStealsLabel: UILabel!
    @IBOutlet weak var vTurnoversLabel: UILabel!
    @IBOutlet weak var vLogoImageView: UIImageView!
    
    var statistics: StatsResults? {
        didSet {
            if let stats = statistics {
                if stats.statistics.count > 0 {
                    hPointsLabel.text = stats.statistics[1].points
                    hFGLabel.text = stats.statistics[1].fgp
                    h3PLabel.text = stats.statistics[1].tpp
                    hFTLabel.text = stats.statistics[1].ftp
                    hReboundLabel.text = stats.statistics[1].totReb
                    hAssistsLabel.text = stats.statistics[1].assists
                    hBlocksLabel.text = stats.statistics[1].blocks
                    hFoulsLabel.text = stats.statistics[1].pFouls
                    hStealsLabel.text = stats.statistics[1].steals
                    hTurnoversLabel.text = stats.statistics[1].turnovers
                    
                    vPointsLabel.text = stats.statistics[0].points
                    vFGLabel.text = stats.statistics[0].fgp
                    v3PLabel.text = stats.statistics[0].tpp
                    vFTLabel.text = stats.statistics[0].ftp
                    vReboundLabel.text = stats.statistics[0].totReb
                    vAssistsLabel.text = stats.statistics[0].assists
                    vBlocksLabel.text = stats.statistics[0].blocks
                    vFoulsLabel.text = stats.statistics[0].pFouls
                    vStealsLabel.text = stats.statistics[0].steals
                    vTurnoversLabel.text = stats.statistics[0].turnovers
                }
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
