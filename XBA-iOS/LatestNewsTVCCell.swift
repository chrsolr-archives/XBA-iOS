//
//  LatestNewsTableViewCell.swift
//  XBA-iOS
//
//  Created by Christian Soler on 10/24/15.
//  Copyright © 2015 iamrelos. All rights reserved.
//

import UIKit
import Alamofire

class LatestNewsTVCCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    func configureCellWith(latestNews: LatestNews){
        titleLabel.text = latestNews.title
        subtitleLabel.text = latestNews.subtitle
        authorLabel.text = latestNews.author
        
        Alamofire.request(.GET, latestNews.imageUrl).response { (request, response, data, error) in
            self.coverImageView?.image = UIImage(data: data!)
        }
    }
}
