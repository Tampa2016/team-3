//
//  ExploreResultsTableViewCell.swift
//  Code_For_Good
//
//  Created by Nicholas Miller on 2/5/16.
//  Copyright © 2016 team3. All rights reserved.
//

import UIKit

class ExploreResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var business: Business! {
        didSet {
            if (business.imageURL != nil) {
                businessImageView.setImageWithURL(business.imageURL!)
            }
            if (business.name != nil) {
                nameLabel.text = business.name!
            }
            if (business.distance != nil) {
                distanceLabel.text = business.distance
            }
//            if (business.reviewCount != nil) {
////                reviewsCountLabel.text = "\(business.reviewCount!) Reviews"
//            }
            if (business.address != nil) {
                addressLabel.text = business.address
            }
            if (business.categories != nil) {
                categoriesLabel.text = business.categories
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        businessImageView.layer.cornerRadius = 3
        businessImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
