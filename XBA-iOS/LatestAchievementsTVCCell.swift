//
//  LatestAchievementsViewCell.swift
//  XBA-iOS
//
//  Created by Christian Soler on 10/26/15.
//  Copyright © 2015 iamrelos. All rights reserved.
//

import UIKit
import Alamofire

class LatestAchievementsTVCCell: UITableViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var submittedByLabel: UILabel!
    @IBOutlet weak var gamerScoreAdded: UILabel!

    func configureCellWith(achievement: LatestAchievements){
        self.titleLabel.text = achievement.title
        self.amountLabel.text = achievement.achievementsAdded
        self.submittedByLabel.text = achievement.submittedBy
        self.gamerScoreAdded.text = achievement.gamerScoreAdded
        
        RequestHandler.getImageFromUrl(achievement.imageUrl, completion: {(response) -> Void in
            self.coverImageView!.image = response
        })
    }
}
