//
//  GrantedUserTableViewCell.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/21/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit

class GrantedUserTableViewCell: UITableViewCell {
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCellWithUser(user:User){
        self.imgUser?.image    = UIImage(named: "user_" + user.userAvatar!)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.imgUser.tintColor = UIColor.darkGrayColor()
        self.lblTitle.text     = user.userUsername
        let df = NSDateFormatter()
        df.dateFormat = "dd/MMM/YYYY"
        self.lblSubtitle.text  = "Given " + df.stringFromDate(UserService.sharedInstance.lastLogin())
    }
    
}
