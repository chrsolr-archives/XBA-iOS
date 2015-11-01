//
//  UpcomingGamesTVC.swift
//  XBA-iOS
//
//  Created by Christian Soler on 10/31/15.
//  Copyright © 2015 iamrelos. All rights reserved.
//

import UIKit

class UpcomingGamesTVC: UITableViewController {

    @IBOutlet var tableview: UITableView!
    
    var games = [UpcomingGame]()
    var category: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableview.estimatedRowHeight = 85.0
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.tableview.tableFooterView = UIView(frame: CGRectZero)
        self.tableview.backgroundColor = UIColor.whiteColor()
        
        self.getUpcomingGames(self.category)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshTable:", name: "refreshUpcomingGames", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.games.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UpcomingGamesCell", forIndexPath: indexPath) as! UpcomingGamesTVCCell
        
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
        
        let game = games[indexPath.row]
        
        cell.configureCellWith(game)

        return cell
    }
    
    func getUpcomingGames(category: String){

        RequestHandler.getUpcomingGames(category, completion: {(result) -> Void in
            self.games = result
            self.tableview.reloadData()
        });
    }
    
    func refreshTable(note: NSNotification){
        
        switch(self.category){
        case "PAL":
            self.category = "PAL"
        case "Xbox Live Arcade":
            self.category = "Arcade"
        case "Xbox One":
            self.category = "xbox-one"
        case "Xbox 360":
            self.category = "xbox-360"
        default:
            self.category = "NTSC"
        }
        
        self.getUpcomingGames(self.category)
    }
}
