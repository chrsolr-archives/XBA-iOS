//
//  RequestHandler.swift
//  XBA-iOS
//
//  Created by Christian Soler on 10/24/15.
//  Copyright © 2015 iamrelos. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class RequestHandler {
    
    func getNews(permalink: String, completion: (data: News) -> Void){
        Alamofire.request(.GET, "http://xba.herokuapp.com/api/news/\(permalink)?key=1234567890")
            .responseJSON { response in
                
                if let value: AnyObject = response.result.value {
                    // handle the results as JSON, without a bunch of nested if loops
                    let post = JSON(value)
                    
                    
                    let news = News()
                    news.title = post["title"].stringValue
                    news.avatar = post["authorAvatar"].stringValue
                    news.author = post["authorName"].stringValue
                    news.datePublished = post["datePublished"].stringValue
                    news.images.append(post["images"][0].stringValue)
                    news.content = ""
                    
                    for item in post["content"] {
                        news.content = news.content + "\n\n" + item.1.stringValue
                    }
                    
                    completion(data: news)
                }
        }
    }
    
    func getImageFromUrl(url: String, completion: (image: UIImage) -> Void){
        Alamofire.request(.GET, url).response { (request, response, data, error) in
            completion(image: UIImage(data: data!)!)
        }
    }
}