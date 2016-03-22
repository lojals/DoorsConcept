//
//  AddBuildingsViewController.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/18/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit
import FlatUIKit

class AddDoorsViewController: UIViewController {
    let doorInteractor = DoorsInteractor()
    
    @IBOutlet weak var yCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgDoors: UIImageView!
    @IBOutlet weak var txtDoorName: UITextField!
    @IBOutlet weak var btnAdd: FUIButton!
    var building:Building!
    
    let randAvatar = Int(arc4random_uniform(UInt32(5)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Door"
        
        btnAdd.buttonColor = UIColor.DCThemeColorMain()
        btnAdd.shadowColor = UIColor.DCThemeColorDarkMain()
        btnAdd.shadowHeight = 3.0
        btnAdd.cornerRadius = 6.0
        btnAdd.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        txtDoorName.delegate = self
        
        self.imgDoors.image = UIImage(named: "door_\(randAvatar)")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.imgDoors.contentMode = .ScaleAspectFit
        self.imgDoors.tintColor = UIColor.grayColor()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        txtDoorName.resignFirstResponder()
    }
    
    @IBAction func addDoor(sender: AnyObject) {
        doorInteractor.saveDoor(building, name: txtDoorName.text!, avatar: "\(randAvatar)")
        self.navigationController?.popViewControllerAnimated(true)
    }
}


extension AddDoorsViewController:UITextFieldDelegate{
    
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