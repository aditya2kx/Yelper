//
//  YelpFilterViewController.swift
//  Yelper
//
//  Created by Aditya Parikh on 9/23/14.
//  Copyright (c) 2014 Aditya Parikh. All rights reserved.
//

import UIKit

class YelpFilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var filterTableView: UITableView!
    let filterData = [["Hot & New", "Offering a Deal", "Delivery"],
                      ["Best Matched", "Distance", "Highest Rated"]]
    let cellId = ["MostPopularCellId", "SortCellId"]
    let sectionHeaders = ["Most Popular", "Sort By"]
    var selectedSections = [false, true]
    var selectedText = ["", "Best Matched"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.title = "Cancel"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = indexPath.row
        let section = indexPath.section
        let currentcellId = cellId[section]
        
        if(section == 0){
            var yelpFilterCell = filterTableView.dequeueReusableCellWithIdentifier(currentcellId) as PopularTableViewCell
            yelpFilterCell.filterNameLabel.text = filterData[section][row]
            return yelpFilterCell
        }else if(section == 1){
            var yelpFilterCell = filterTableView.dequeueReusableCellWithIdentifier(currentcellId) as SortTableViewCell
            if(selectedSections[1] == false){
                yelpFilterCell.filterNameLabel.text = filterData[section][row]
            }else{
                yelpFilterCell.filterNameLabel.text = selectedText[section]
                
            }
            return yelpFilterCell
            
        }else{
            return UITableViewCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //println("No of rows: \(yelpDataDictionary.count)");
        if(section == 1 && selectedSections[section] == true){
            return 1;
        }
        return filterData[section].count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaders[section]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 1){
            selectedText[1] = filterData[indexPath.section][indexPath.row]
            selectedSections[1] = !selectedSections[1]
            filterTableView.reloadData()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "SearchSegueId")
        {
        // Get reference to the destination view controller
            var yelpSearchViewController = segue.destinationViewController as ViewController
            for var i = 0; i < filterTableView.numberOfRowsInSection(0); i++
            {
                var yelpFilterCell = filterTableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as PopularTableViewCell
                yelpSearchViewController.searchTerms[i] = yelpFilterCell.filterSwitch.on
            }
        
        }
        
    }


}
