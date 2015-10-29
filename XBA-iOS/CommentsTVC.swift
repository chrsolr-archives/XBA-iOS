//
//  NewsCommentsTableViewController.swift
//  XBA-iOS
//
//  Created by Christian Soler on 10/27/15.
//  Copyright © 2015 iamrelos. All rights reserved.
//

import UIKit
import Alamofire

class CommentsTVC: UITableViewController {

    @IBOutlet var tableview: UITableView!
    
    var comments = [Comment]()
    var permalink: String!
    var nID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.estimatedRowHeight = 118.0
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.tableview.tableFooterView = UIView(frame: CGRectZero)
        self.tableview.backgroundColor = UIColor.whiteColor()
        
        self.getComments()
    }

    func refreshComments(){
        self.tableview.reloadData()
    }
    
    @IBAction func dismissView(sender: AnyObject) {
         self.navigationController!.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableview.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of row
        return comments.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentsCell", forIndexPath: indexPath) as! CommentsTVCCell
        
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

        // Configure the cell...
        cell.configureCellWith(comments[indexPath.row]);

        return cell
    }
    
    func getComments(){
        RequestHandler().getComments(self.permalink, nID: self.nID, completion: { (result) -> Void in
            self.comments = result
            self.tableview.reloadData()
        })
    }
}
