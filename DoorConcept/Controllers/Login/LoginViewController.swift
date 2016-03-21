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
    
    var txtEditing = -1
    
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
        self.txtUsername.tag      = 0
        
        self.txtPassword.delegate = self
        self.txtPassword.tag      = 1
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        txtUsername.resignFirstResponder()
        txtPassword.resignFirstResponder()
    }
    
    @IBAction func DoLogin(sender: AnyObject) {
        UserService.sharedInstance.Login(self.txtUsername.text!, password: self.txtPassword.text!) { (logged, error) -> Void in
            if logged{
                print("Logged In")
                let buildings = self.storyboard?.instantiateViewControllerWithIdentifier("GenericTabBarViewController")
                self.presentViewController(buildings!, animated: true, completion: nil)
            }else{
                print(error!)
                let alert : UIAlertController = UIAlertController(title: "Oops!", message: error!, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style:.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
}

extension LoginViewController:UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.YCenterConstraint.constant = -textField.frame.origin.y + 120
        UIView.animateWithDuration(0.3) { () -> Void in
            self.view.layoutIfNeeded()
        }
        txtEditing = textField.tag
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if textField.tag == txtEditing{
            self.YCenterConstraint.constant = 0
            UIView.animateWithDuration(0.3) { () -> Void in
                self.view.layoutIfNeeded()
            }
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}