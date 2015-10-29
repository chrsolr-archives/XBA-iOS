//
//  LatestAchievements.swift
//  XBA-iOS
//
//  Created by Christian Soler on 10/26/15.
//  Copyright © 2015 iamrelos. All rights reserved.
//

import Foundation

class LatestAchievements {
    var title: String!
    var imageUrl: String!
    var achievementsAdded: String!
    var gamerScoreAdded: String!
    var submittedBy: String!
    var gamePermalink: String!
    var comments: [Comment]
    
    init(){
        comments = [Comment]()
    }
}