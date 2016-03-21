//
//  ProfileViewController.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/19/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit
import FlatUIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblLastLogin: UILabel!
    @IBOutlet weak var btnLogout: FUIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgProfile.image     = UIImage(named:"user_0")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.imgProfile.tintColor = UIColor.DCThemeColorContrastMain()
        
        self.btnLogout.buttonColor  = UIColor.DCThemeColorMain()
        self.btnLogout.shadowColor  = UIColor.DCThemeColorDarkMain()
        self.btnLogout.shadowHeight = 3.0
        self.btnLogout.cornerRadius = 6.0
        self.btnLogout.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func logout(sender: AnyObject) {
        LoginService.sharedInstance.Logout()
    }
}
