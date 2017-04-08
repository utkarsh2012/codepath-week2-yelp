//
//  DealCell.swift
//  Yelp
//
//  Created by Utkarsh Sengar on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol DealCellDelegate {
    @objc optional func dealCell(dealCell: DealCell, didChangeValue value: Bool)
}


class DealCell: UITableViewCell {
    @IBOutlet weak var dealSwitch: UISwitch!
    weak var delegate: DealCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        dealSwitch.addTarget(self, action: #selector(DealCell.switchValueChanged), for: UIControlEvents.valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func switchValueChanged() {
        delegate?.dealCell!(dealCell: self, didChangeValue: dealSwitch.isOn)
    }
}
