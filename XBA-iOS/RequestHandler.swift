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
    
    func getLatestNews(pageNumber: Int, completion: (data: [LatestNews]) -> Void){
        
        var latestNews = [LatestNews]()
        let url = self.fixEncodingUrl("http://xba.herokuapp.com/api/latest/news?page=\(pageNumber)&key=1234567890")
        
        Alamofire.request(.GET, url)
            .responseJSON { response in
                
                if let value: AnyObject = response.result.value {
                    // handle the results as JSON, without a bunch of nested if loops
                    let post = JSON(value)
                    
                    for item in post {
                        let news = LatestNews()
                        news.title = item.1["title"].stringValue
                        news.subtitle = item.1["subtitle"].stringValue
                        news.imageUrl = item.1["imageUrl"].stringValue
                        news.author = item.1["author"].stringValue
                        news.permalink = item.1["permalink"].stringValue
                        
                        latestNews.append(news)
                    }
                    
                    completion(data: latestNews)
                }
        }
    }
    
    func getNews(permalink: String, completion: (data: News) -> Void){
        let url = self.fixEncodingUrl("http://xba.herokuapp.com/api/news/\(permalink)?key=1234567890")

        Alamofire.request(.GET, url)
            .responseJSON { response in

                if let value: AnyObject = response.result.value {
                    // handle the results as JSON, without a bunch of nested if loops
                    let post = JSON(value)
                    
                    let news = News()
                    news.title = post["title"].stringValue
                    news.avatar = post["authorAvatar"].stringValue
                    news.author = post["authorName"].stringValue
                    news.firstName = post["authorFirstName"].stringValue
                    news.lastName = post["authorLastName"].stringValue
                    news.datePublished = post["datePublished"].stringValue
                    news.images.append(post["images"][0].stringValue)
                    news.content = ""
                    
                    for item in post["content"] {
                        news.content = news.content + "\n\n" + item.1.stringValue
                    }
                    
                    var i = 1
                    for item in post["comments"] {
                        let comment = Comment()
                        comment.author = "Comment #\(i) by \(item.1["author"].stringValue)"
                        comment.createdDate = item.1["createdDate"].stringValue
                        comment.content = item.1["content"].stringValue
                        
                        news.comments.append(comment)
                        i++;
                    }
                    
                    completion(data: news)
                }
        }
    }
    
    func getLatestAchievements(pageNumber: Int, completion: (data: [LatestAchievements]) -> Void){
        let url = self.fixEncodingUrl("http://xba.herokuapp.com/api/latest/achievements?page=\(pageNumber)&key=1234567890")
        var latestAchievements = [LatestAchievements]()
        
        Alamofire.request(.GET, url)
            .responseJSON { response in
                
                if let value: AnyObject = response.result.value {
                    // handle the results as JSON, without a bunch of nested if loops
                    let achievements = JSON(value)
                    
                    for item in achievements {
                        let achievement = LatestAchievements()
                        achievement.title = item.1["title"].stringValue
                        achievement.submittedBy = item.1["submittedBy"].stringValue
                        achievement.imageUrl = item.1["imageUrl"].stringValue
                        achievement.achievementsAdded = item.1["achievementsAdded"].stringValue
                        achievement.gamePermalink = item.1["gamePermalink"].stringValue
                        achievement.gamerScoreAdded = item.1["gamerScoreAdded"].stringValue
                        achievement.commentsPermalink = item.1["commentsPermalink"].stringValue
                        
                        latestAchievements.append(achievement)
                    }
                    
                    completion(data: latestAchievements)
                }
        }
    }
    
    func getImageFromUrl(var url: String, completion: (image: UIImage) -> Void){
        url = self.fixEncodingUrl(url)
        
        Alamofire.request(.GET, url).response { (request, response, data, error) in
            completion(image: UIImage(data: data!)!)
        }
    }
    
    func getComments(permalink: String, completion: (comments: [Comment]) -> Void){
        let url = self.fixEncodingUrl("http://xba.herokuapp.com/api/latest/achievements/comments\(permalink)?key=1234567890")
        
        print(url)
        
        Alamofire.request(.GET, url).responseJSON { response in
            if let value: AnyObject = response.result.value {
                let comments = JSON(value)
                
                var data = [Comment()]
                
                var i = 1
                for item in comments {
                    let comment = Comment()
                    comment.author = "Comment #\(i) by \(item.1["author"].stringValue)"
                    comment.content = item.1["content"].stringValue
                    comment.createdDate = item.1["createdDate"].stringValue
                    
                    data.append(comment)
                    i++
                }
                
                completion(comments: data)
            }
        }
    }
    
    func fixEncodingUrl(url: String) -> String {
        return url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    }
}