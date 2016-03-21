//
//  BuildingsTableViewCell.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/18/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit
import SESlideTableViewCell

class HistoryTableViewCell: SESlideTableViewCell {

    @IBOutlet weak var imgHistory: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var stateIndicator: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

    }
}
