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
        
        let user = UserService.sharedInstance.currentUser! as User
        
        self.imgProfile.image       = UIImage(named:"user_\(user.userAvatar!)")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.imgProfile.tintColor   = UIColor.DCThemeColorContrastMain()

        self.lblUsername.text       = user.userUsername!
        
        let df = NSDateFormatter()
        df.dateFormat = "dd/MMM/YYYY"
        self.lblLastLogin.text      = "Last login " + df.stringFromDate(UserService.sharedInstance.lastLogin())
        
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
        UserService.sharedInstance.Logout()
        let loginView = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController")
        self.presentViewController(loginView!, animated: true, completion: nil)
    }
}
