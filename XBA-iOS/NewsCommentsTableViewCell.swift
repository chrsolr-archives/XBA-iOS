//
//  NewsCommentsTableViewCell.swift
//  XBA-iOS
//
//  Created by Christian Soler on 10/27/15.
//  Copyright © 2015 iamrelos. All rights reserved.
//

import UIKit

class NewsCommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    func configureCellWith(comment: Comment){
        authorLabel.text = comment.author;
        createdDateLabel.text = comment.createdDate
        contentLabel.text = comment.content
    }
}
