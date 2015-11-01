//
//  LatestNewsViewController.swift
//  XBA-iOS
//
//  Created by Christian Soler on 10/24/15.
//  Copyright © 2015 iamrelos. All rights reserved.
//

import UIKit
import Alamofire

class LatestNewsTVC: UITableViewController {

    @IBOutlet var tableview: UITableView!
    
    var latestNews: [LatestNews] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getLatestNews(1)
        
        self.tableview.estimatedRowHeight = 240.0
        self.tableview.rowHeight = UITableViewAutomaticDimension
        
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.tableview.tableFooterView = UIView(frame: CGRectZero)
        self.tableview.backgroundColor = UIColor.whiteColor()
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
        let cell = tableView.dequeueReusableCellWithIdentifier("LatestNewsCellIdentifier", forIndexPath: indexPath) as! LatestNewsTVCCell

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
                    let newsVC = segue.destinationViewController as? NewsVC
                
                    if let index = self.tableview.indexPathForCell(sender as! UITableViewCell) {
                        newsVC!.newsPermalink = latestNews[index.row].permalink
                    }
                default: break
            }
        }
    }
    
    
    func getLatestNews(pageNumber: Int){
        RequestHandler.getLatestNews(pageNumber, completion: {(result) -> Void in
            self.latestNews = [LatestNews]()
            self.latestNews = result;
            self.tableview.reloadData()
            self.refreshControl?.endRefreshing()
        })
    }
    
    func refresh(sender: AnyObject){
        self.getLatestNews(1)
    }
}
