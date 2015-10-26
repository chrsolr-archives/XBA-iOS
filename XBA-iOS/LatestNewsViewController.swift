//
//  LatestNewsViewController.swift
//  XBA-iOS
//
//  Created by Christian Soler on 10/24/15.
//  Copyright © 2015 iamrelos. All rights reserved.
//

import UIKit
import Alamofire

class LatestNewsViewController: UITableViewController {

    @IBOutlet var tableview: UITableView!
    
    var latestNews: [LatestNews] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getLatestNews(1)
        
        self.tableview.estimatedRowHeight = 240.0
        self.tableview.rowHeight = UITableViewAutomaticDimension
    }

    override func viewDidAppear(animated: Bool) {
        tableview.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.latestNews.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LatestNewsCellIdentifier", forIndexPath: indexPath) as! LatestNewsTableViewCell

        // Remove seperator inset
        if cell.respondsToSelector("setSeparatorInset:") {
            cell.separatorInset = UIEdgeInsetsZero
        }
        
        // Prevent the cell from inheriting the Table View's margin settings
        if cell.respondsToSelector("setPreservesSuperviewLayoutMargins:") {
            cell.preservesSuperviewLayoutMargins = false
        }
        
        // Explictly set your cell's layout margins
        if cell.respondsToSelector("setLayoutMargins:") {
            cell.layoutMargins = UIEdgeInsetsZero
        }
        
        let news = latestNews[indexPath.row]
        
        cell.configureCellWith(news)
        
        

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
                case "NewsDetailsIdentifier":
                    let newsVC = segue.destinationViewController as? NewsViewController
                
                    if let index = self.tableview.indexPathForCell(sender as! UITableViewCell) {
                        newsVC!.newsPermalink = latestNews[index.row].permalink
                    }
                default: break
            }
        }
    }
    
    
    func getLatestNews(pageNumber: Int){
        Alamofire.request(.GET, "http://xba.herokuapp.com/api/latest/news?page=\(pageNumber)&key=1234567890")
            .responseJSON { response in
                
                if let value: AnyObject = response.result.value {
                    // handle the results as JSON, without a bunch of nested if loops
                    let post = JSON(value)
                    
                    
                    for item in post {
                        let title = item.1["title"].stringValue
                        let subtitle = item.1["subtitle"].stringValue
                        let imageUrl = item.1["imageUrl"].stringValue
                        let author = item.1["author"].stringValue
                        let permalink = item.1["permalink"].stringValue
                        
                        let news = LatestNews(title: title, subtitle: subtitle, imageUrl: imageUrl, author: author, permalink: permalink)
                        
                        self.latestNews.append(news)
                    }
                    
                    self.tableview.reloadData()
                }
        }
    }
}
