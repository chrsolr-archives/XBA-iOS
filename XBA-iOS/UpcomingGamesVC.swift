//
//  UpcomingGames.swift
//  XBA-iOS
//
//  Created by Christian Soler on 10/30/15.
//  Copyright © 2015 iamrelos. All rights reserved.
//

import UIKit

class UpcomingGamesVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var categoryBtn: UIButton!
    @IBOutlet weak var categoryTF: UITextField!
    
    let categories = ["NTSC", "PAL", "Xbox Live Arcade", "Xbox One", "Xbox 360"]
    var tableVC: UpcomingGamesTVC!
    var categoriesPicker = UIPickerView()
    var isPickerShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoriesPicker.delegate = self;
        self.categoriesPicker.dataSource = self;
        self.categoriesPicker.backgroundColor = UIColor.whiteColor()
        self.categoryTF.inputView = self.categoriesPicker;
        self.categoryTF.text = self.categories[0]

    }
    
    @IBAction func pickerShowAndHide(sender: AnyObject) {
        if  self.isPickerShowing {
            self.categoryTF.resignFirstResponder()
            self.categoryBtn.setTitle(self.categoryTF.text, forState: .Normal)
            self.tableVC.category = self.categoryTF.text
            NSNotificationCenter.defaultCenter().postNotificationName("refreshUpcomingGames", object: nil)
        } else {
            self.categoryTF.becomeFirstResponder()
            self.categoryBtn.setTitle("Select", forState: .Normal)
        }
        
        self.isPickerShowing = !self.isPickerShowing
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.categories.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.categories[row]
    }
    
    // Catpure the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.categoryBtn.setTitle("Done", forState: .Normal)
        self.categoryTF.text = self.categories[row]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            
            if identifier == "UpcomingGameIdentifier" {
                self.tableVC = segue.destinationViewController as? UpcomingGamesTVC
                self.tableVC?.category = "NTSC"
            }
        }
    }
}
