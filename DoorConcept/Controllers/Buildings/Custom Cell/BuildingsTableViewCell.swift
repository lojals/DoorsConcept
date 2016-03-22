//
//  BuildingsTableViewCell.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/18/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit
import SESlideTableViewCell

class BuildingsTableViewCell: SESlideTableViewCell {

    @IBOutlet weak var imgBuilding: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addRightButtonWithImage(UIImage(named: "btn_trash"), backgroundColor: UIColor.alizarinColor())
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            self.imgBuilding.tintColor = UIColor.DCThemeColorDarkMain()
            self.lblTitle.textColor    = UIColor.DCThemeColorDarkMain()
            self.lblSubtitle.textColor = UIColor.DCThemeColorDarkMain()
        }else{
            self.imgBuilding.tintColor = UIColor.darkGrayColor()
            self.lblTitle.textColor    = UIColor.blackColor()
            self.lblSubtitle.textColor = UIColor.darkGrayColor()
        }
    }
    
    func configureCellWithBuilding(building:Building){
        self.imgBuilding?.image = UIImage(named: "build_" + building.buildingAvatar!)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.lblTitle.text      = building.buildingName!
        self.lblSubtitle.text   = "\(building.doors?.count ?? 0 ) Doors"
    }
}
