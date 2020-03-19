//
//  LoadingTableViewCell.swift
//  iosScore
//
//  Created by Lewis Kim on 2020-03-10.
//  Copyright © 2020 Lewis Kim. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        activityIndicator.startAnimating()
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
