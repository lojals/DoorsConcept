//
//  LoginViewController.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/19/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit
import FlatUIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var txtUsername: FUITextField!
    @IBOutlet weak var txtPassword: FUITextField!
    @IBOutlet weak var btnLogin:    FUIButton!
    @IBOutlet weak var YCenterConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgLogo.image     = UIImage(named:"Logo")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.imgLogo.tintColor = UIColor.DCThemeColorMain()
        
        self.btnLogin.buttonColor  = UIColor.DCThemeColorMain()
        self.btnLogin.shadowColor  = UIColor.DCThemeColorDarkMain()
        self.btnLogin.shadowHeight = 3.0
        self.btnLogin.cornerRadius = 6.0
        self.btnLogin.setTitleColor(UIColor.whiteColor(), forState: .Normal)

        self.txtUsername.delegate = self
        self.txtPassword.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func DoLogin(sender: AnyObject) {
        
    }
}

extension LoginViewController:UITextFieldDelegate{
    
}