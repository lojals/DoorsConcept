//
//  AddBuildingsViewController.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/18/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit
import FlatUIKit

class AddBuildingsViewController: UIViewController {

    @IBOutlet weak var yCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgBuilding: UIImageView!
    @IBOutlet weak var txtBuildingName: UITextField!
    @IBOutlet weak var btnAdd: FUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Building"
        
        btnAdd.buttonColor = UIColor.DCThemeColorMain()
        btnAdd.shadowColor = UIColor.DCThemeColorDarkMain()
        btnAdd.shadowHeight = 3.0
        btnAdd.cornerRadius = 6.0
        btnAdd.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        txtBuildingName.delegate = self
        
        self.imgBuilding.image = UIImage(named: "build_big_\(Int(arc4random_uniform(UInt32(5))))")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.imgBuilding.contentMode = .ScaleAspectFit
        self.imgBuilding.tintColor = UIColor.grayColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        txtBuildingName.resignFirstResponder()
    }
    
    @IBAction func addBuilding(sender: AnyObject) {
        print("Adding")
    }
}


extension AddBuildingsViewController:UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.yCenterConstraint.constant = -100
        UIView.animateWithDuration(0.3) { () -> Void in
            self.view.layoutIfNeeded()
        }
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        self.yCenterConstraint.constant = 0
        UIView.animateWithDuration(0.3) { () -> Void in
            self.view.layoutIfNeeded()
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
}