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
    
    static func getLatestNews(pageNumber: Int, completion: (data: [LatestNews]) -> Void){
        
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
                        news.permalink = item.1["newsPermalink"].stringValue
                        
                        latestNews.append(news)
                    }
                    
                    completion(data: latestNews)
                }
        }
    }
    
    static func getNews(permalink: String, completion: (data: News) -> Void){
        let url = self.fixEncodingUrl("http://xba.herokuapp.com/api/news?permalink=\(permalink)&key=1234567890")

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
                    news.nID = post["nID"].stringValue
                    news.content = ""
                    
                    for item in post["content"] {
                        news.content = news.content + "\n\n" + item.1.stringValue
                    }
                    
                    completion(data: news)
                }
        }
    }
    
    static func getLatestAchievements(pageNumber: Int, completion: (data: [LatestAchievements]) -> Void){
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
    
    static func getImageFromUrl(var url: String, completion: (image: UIImage) -> Void){
        url = self.fixEncodingUrl(url)
        
        Alamofire.request(.GET, url).response { (request, response, data, error) in
            completion(image: UIImage(data: data!)!)
        }
    }
    
    static func getComments(permalink: String!, nID: String!, completion: (comments: [Comment]) -> Void){
        var url: String
        
        if (nID == nil) {
            url = self.fixEncodingUrl("http://xba.herokuapp.com/api/comments?permalink=\(permalink)&key=1234567890")
        } else {
            url = self.fixEncodingUrl("http://xba.herokuapp.com/api/comments?nID=\(nID)&key=1234567890")
        }
        
        Alamofire.request(.GET, url).responseJSON { response in
            if let value: AnyObject = response.result.value {
                let json = JSON(value)
                
                let data = self.parseCommentsJSON(json)
                
                completion(comments: data)
            }
        }
    }
    
    static func getUpcomingGames(category: String, completion: (games: [UpcomingGame]) -> Void){
        let url = self.fixEncodingUrl("http://xba.herokuapp.com/api/upcoming/games?category=\(category)&key=1234567890")
        
        Alamofire.request(.GET, url).responseJSON { response in
            if let value: AnyObject = response.result.value {
                let json = JSON(value)
                
                var data = [UpcomingGame]()
                
                for item in json {
                    let game = UpcomingGame()
                    game.date = item.1["date"].stringValue
                    game.gameTitle = item.1["game"].stringValue
                    game.gamePermalink = item.1["gamePermalink"].stringValue
                    
                    data.append(game)
                }
                
                completion(games: data)
            }
        }
    }
    
    static private func fixEncodingUrl(url: String) -> String {
        return url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    }
    
    static private func parseCommentsJSON(json: JSON) -> [Comment] {
        var data = [Comment]()
        
        var i = 1
        for item in json {
            let comment = Comment()
            comment.author = "Comment #\(i) by \(item.1["author"].stringValue)"
            comment.content = item.1["content"].stringValue
            comment.createdDate = item.1["createdDate"].stringValue
            
            data.append(comment)
            i++
        }
        
        return data
    }
}