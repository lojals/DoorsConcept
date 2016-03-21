//
//  DoorInformation.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/20/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit

class DoorInformation: UIView {

    var imgDoor:UIImageView!
    var lblInformation:UILabel!
    var line:UIView!
    var lblStatus:UILabel!
    
    override init(frame:CGRect){
        super.init(frame: frame)        
        self.addUIComponents()
        self.addUIConstraints()
    }
    
    private func addUIComponents(){
        imgDoor                 = UIImageView()
        imgDoor.image           = UIImage(named: "door_0")
        imgDoor.contentMode     = .ScaleAspectFit
        imgDoor.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imgDoor)
        
        lblInformation               = UILabel()
        lblInformation.font          = UIFont.lightFlatFontOfSize(18)
        lblInformation.numberOfLines = 0
        lblInformation.text          = "Location: Clay Solutions \nStatus: Closed"
        lblInformation.translatesAutoresizingMaskIntoConstraints = false
        lblInformation.sizeToFit()
        self.addSubview(lblInformation)
        
        line                 = UIView()
        line.backgroundColor = UIColor.grayColor()
        line.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(line)
        
        lblStatus      = UILabel()
        lblStatus.font = UIFont.lightFlatFontOfSize(20)
        lblStatus.text = "ACCESS DENIED!"
        lblStatus.textColor = UIColor.alizarinColor()
        lblStatus.translatesAutoresizingMaskIntoConstraints = false
        lblStatus.sizeToFit()
        self.addSubview(lblStatus)
        
    }
    
    private func addUIConstraints(){
        let views = ["imgDoor":imgDoor,"lblInformation":lblInformation,"line":line,"lblStatus":lblStatus]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[imgDoor]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-24-[lblInformation]-8-[line(1)]-14-[lblStatus]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[imgDoor(102)]-2-[lblInformation]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[imgDoor]-2-[line]-15-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraint(NSLayoutConstraint(item: self.lblStatus, attribute: .Left, relatedBy: .Equal, toItem: line, attribute: .Left, multiplier: 1, constant: 0))
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("Method not implemented yet")
    }

}