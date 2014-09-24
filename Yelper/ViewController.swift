//
//  ViewController.swift
//  Yelper
//
//  Created by Aditya Parikh on 9/23/14.
//  Copyright (c) 2014 Aditya Parikh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    var client: YelpClient!
    var yelpSearchBar : UISearchBar!
    let yelpConsumerKey = "B2owgjbOAuxV_ic22iEiUA"
    let yelpConsumerSecret = "b9mxr3k56gBng6a_BFfJ1uyqrfc"
    let yelpToken = "tjSj05RhWoDr0t904z2fU6dTP78WIwPk"
    let yelpTokenSecret = "Y1Mgz331RikYSJAHGpllK6c8WIY"
    var yelpDataDictionary = []
    var searchTerms = [false, false, false]
    var searchText = "indian food"
    
    @IBOutlet var yelpSearchTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(yelpSearchBar == nil){
            initSearchBar()
        }
        searchYelp()
        //yelpSearchDisplayController.displaysSearchBarInNavigationBar = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initSearchBar(){
        var yelpSearchBarFrame = CGRect(x: 100, y: 10, width: 200, height: 30)
        yelpSearchBar = UISearchBar(frame: yelpSearchBarFrame)
        yelpSearchBar.delegate = self;
        self.navigationItem.titleView = yelpSearchBar
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var yelpSearchCell = yelpSearchTableView.dequeueReusableCellWithIdentifier("YELPCELLID") as YelpSearchTableViewCell
        var result = yelpDataDictionary[indexPath.row] as NSDictionary
        if(result["image_url"] != nil){
            yelpSearchCell.yelpSearchTmb.setImageWithURL(NSURL(string: result["image_url"] as NSString))
        }
        if(result["rating_img_url"] != nil){
            yelpSearchCell.yelpRatingsImageView.setImageWithURL(NSURL(string: result["rating_img_url"] as NSString))
        }
        if(result["name"] != nil){
            let name = result["name"] as NSString
            yelpSearchCell.yelpTitleLabel.text = "\(indexPath.row + 1). \(name)"
        }
        if(result["deals"] != nil){
            let deals = result["deals"] as NSArray
            println("Total Deals: \(deals.count)")
            let firstDeal = deals[0] as NSDictionary
            let firstDealTitle = firstDeal["title"] as NSString
            yelpSearchCell.yelpDealsLabel.text = "\(indexPath.row + 1). \(firstDealTitle)"
        }else{
            yelpSearchCell.yelpDealsLabel.text = ""
        }
        if(result["review_count"] != nil){
            let reviewCount = result["review_count"] as NSNumber
            yelpSearchCell.yelpRatingsLabel.text = "\(reviewCount) Reviews"
        }
        if(result["distance"] != nil){
            let reviewCount = result["distance"] as NSNumber
            yelpSearchCell.yelpRatingsLabel.text = "\(reviewCount) mi"
        }
        if(result["location"] != nil){
            let location = result["location"] as NSDictionary
            let address = location["address"] as NSArray
            if(address.count > 0){
                yelpSearchCell.yelpAddressLabel.text = address[0] as NSString
            }else{
                yelpSearchCell.yelpAddressLabel.text = "Not Available"
            }
        }
        if(result["categories"] != nil){
            let categories = result["categories"] as NSArray
            var categoryText = ""
            var catIndex = 0;
            for category in categories as NSArray{
                let  currentCategory : NSString = "\(category[0])"
                println(currentCategory)
                if(catIndex == 0){
                    categoryText = categoryText.stringByAppendingString("\(currentCategory)")
                }else{
                    categoryText = categoryText.stringByAppendingString(", \(currentCategory)")
                }
                catIndex++
            }
            yelpSearchCell.yelpCategoryLabel.text = categoryText as NSString
        }
        
        return yelpSearchCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("No of rows: \(yelpDataDictionary.count)");
        return yelpDataDictionary.count
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if(countElements(searchText) != 0){
            self.searchText = searchText
            searchYelp()
        }else{
            //getLatestMoviesData()
        }
    }
    
    func searchYelp(){
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm(searchText, dealsFilter: searchTerms[1],success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println(response)
            var data = response as NSDictionary
            self.yelpDataDictionary = data["businesses"] as NSArray
            self.yelpSearchTableView.reloadData()
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("network error")
                //self.showError()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        /*if (segue.identifier == "FilterShowSegueId")
        {
            // Get reference to the destination view controller
            var yelpFilterViewController = segue.destinationViewController as YelpFilterViewController
            

        }*/
    }
}

