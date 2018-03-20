//
//  GarbageTruckTableViewCell.swift
//  NTPCGarbageTruckList
//
//  Created by Hao Lee on 2018/3/20.
//

import UIKit

class GarbageTruckTableViewCell: UITableViewCell, Reusable {

    @IBOutlet var timeLabel: UILabel?
    @IBOutlet var nameLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
