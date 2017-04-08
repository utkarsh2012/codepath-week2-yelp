//
//  SortCell.swift
//  Yelp
//
//  Created by Utkarsh Sengar on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SortCellDelegate {
    @objc optional func sortCell(sortCell: SortCell, didChangeValue value: Int)
}

class SortCell: UITableViewCell {

    @IBOutlet weak var sortRb: RadioButton!
    @IBOutlet weak var sortLabel: UILabel!
    weak var delegate: SortCellDelegate?
    var sortValue: Int!

    override func awakeFromNib() {
        super.awakeFromNib()
        sortRb.addTarget(self, action: #selector(sortRadioButtonSelected), for: UIControlEvents.allTouchEvents)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func sortRadioButtonSelected(){
        delegate?.sortCell!(sortCell: self, didChangeValue: self.sortValue)
    }
}
