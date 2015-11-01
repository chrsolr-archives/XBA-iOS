//
//  UpcomingGamesTVCCell.swift
//  XBA-iOS
//
//  Created by Christian Soler on 11/1/15.
//  Copyright © 2015 iamrelos. All rights reserved.
//

import UIKit

class UpcomingGamesTVCCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    func configureCellWith(upcomingGame: UpcomingGame){
        titleLabel.text = upcomingGame.gameTitle
        dateLabel.text = upcomingGame.date
    }
}
