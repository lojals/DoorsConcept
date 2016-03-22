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

    @IBOutlet weak var imgHistory:     UIImageView!
    @IBOutlet weak var lblTitle:       UILabel!
    @IBOutlet weak var lblDate:        UILabel!
    @IBOutlet weak var stateIndicator: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCellWithHistory(history:History){
        self.imgHistory?.image    = UIImage(named: "user_" + history.user!.userAvatar!)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.imgHistory.tintColor = UIColor.darkGrayColor()
        
        var st = ""
        
        switch(history.state!){
            case("authorized"): stateIndicator.backgroundColor = UIColor.DCThemeColorMain()
                                st = " opened "
            case("denied"):     stateIndicator.backgroundColor = UIColor.alizarinColor()
                                st = " tried to open "
            default: break
        }
        
        let fst = history.user!.userUsername!
        let snd = (history.door?.doorName) ?? "Deleted door"
        let trd = (history.door?.building?.buildingName) ?? "Deleted door"
        let infoStr       = NSMutableAttributedString(string: fst + st + snd + " @ " + trd)
        
        //String metrics
        let fL = fst.characters.count
        let sL = st.characters.count
        
        infoStr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(17, weight: 0.5), range: NSMakeRange(0, fL))
        infoStr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(17, weight: 0.5), range: NSMakeRange(fL+sL, snd.characters.count))
        infoStr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(17, weight: 0.5), range: NSMakeRange(fL+sL+snd.characters.count+3, trd.characters.count))
        
        
        self.lblTitle.attributedText  = infoStr
        let df                    = NSDateFormatter()
        df.dateFormat             = "dd/MMM/YYYY HH:mm"
        self.lblDate.text         = df.stringFromDate(history.date!)
    }
}
