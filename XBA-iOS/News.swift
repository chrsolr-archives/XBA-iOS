//
//  News.swift
//  XBA-iOS
//
//  Created by Christian Soler on 10/24/15.
//  Copyright © 2015 iamrelos. All rights reserved.
//

import Foundation

class News {
    var avatar: String!
    var author: String!
    var datePublished: String!
    var title: String!
    var images: [String]
    var content: String!
    
    init(){
        images = [String]()
    }
}