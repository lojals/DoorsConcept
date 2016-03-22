//
//  BuildingsTableViewCell.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/18/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit
import SESlideTableViewCell

class DoorsTableViewCell: SESlideTableViewCell {

    @IBOutlet weak var imgDoor: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addRightButtonWithImage(UIImage(named: "btn_trash"), backgroundColor: UIColor.alizarinColor())
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            self.imgDoor.tintColor = UIColor.DCThemeColorDarkMain()
            self.lblTitle.textColor    = UIColor.DCThemeColorDarkMain()
            self.lblSubtitle.textColor = UIColor.DCThemeColorDarkMain()
        }else{
            self.imgDoor.tintColor = UIColor.darkGrayColor()
            self.lblTitle.textColor    = UIColor.blackColor()
            self.lblSubtitle.textColor = UIColor.darkGrayColor()
        }
    }
    
    func configureCellWithDoor(door:Door){
        self.imgDoor?.image   = UIImage(named: "door_" + door.doorAvatar!)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.lblTitle.text    = door.doorName!
        self.lblSubtitle.text = "\(door.doorState!)"
    }

}
