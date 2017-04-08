//
//  DistanceCell.swift
//  Yelp
//
//  Created by Utkarsh Sengar on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol DistanceCellDelegate {
    @objc optional func distanceCell(distanceCell: DistanceCell, didChangeValue value:Int)
}

class DistanceCell: UITableViewCell {

    @IBOutlet weak var distanceLabel: UILabel!
    weak var delegate: DistanceCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
