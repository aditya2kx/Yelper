//
//  YelpSearchTableViewCell.swift
//  Yelper
//
//  Created by Aditya Parikh on 9/23/14.
//  Copyright (c) 2014 Aditya Parikh. All rights reserved.
//

import UIKit

class YelpSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var yelpDealsLabel: UILabel!
    @IBOutlet weak var yelpPriceLabel: UILabel!
    @IBOutlet weak var yelpDistanceLabel: UILabel!
    @IBOutlet weak var yelpRatingsImageView: UIImageView!
    @IBOutlet weak var yelpSearchTmb: UIImageView!
    @IBOutlet weak var yelpTitleLabel: UILabel!

    @IBOutlet weak var yelpRatingsLabel: UILabel!
    @IBOutlet weak var yelpCategoryLabel: UILabel!
    @IBOutlet weak var yelpAddressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
