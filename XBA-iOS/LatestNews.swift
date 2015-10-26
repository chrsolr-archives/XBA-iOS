//
//  LatestNews.swift
//  XBA-iOS
//
//  Created by Christian Soler on 10/24/15.
//  Copyright © 2015 iamrelos. All rights reserved.
//

import Foundation

class LatestNews {
    var title: String
    var subtitle: String
    var imageUrl: String
    var author: String
    var permalink: String
    
    init(title: String, subtitle: String, imageUrl: String, author: String, permalink: String){
        self.title = title
        self.subtitle = subtitle
        self.imageUrl = imageUrl
        self.author = author
        self.permalink = permalink
    }
}