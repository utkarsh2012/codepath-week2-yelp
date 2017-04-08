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

    @IBOutlet weak var distanceRb: RadioButton!
    @IBOutlet weak var distanceLabel: UILabel!
    weak var delegate: DistanceCellDelegate?
    var distanceValue: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        distanceRb.addTarget(self, action: #selector(distanceRadioButtonSelected), for: UIControlEvents.allTouchEvents)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func distanceRadioButtonSelected(){
        delegate?.distanceCell!(distanceCell: self, didChangeValue: self.distanceValue)
    }
}
