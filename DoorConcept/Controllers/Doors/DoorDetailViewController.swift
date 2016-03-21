//
//  DoorDetailViewController.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/19/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit
import FlatUIKit

class DoorDetailViewController: UIViewController {

    var btnOpen:UIButton!
    var imgDoor:UIImageView!
    var tblGrantedUsers:UITableView!
    var progress:UIProgressView!
    var lblInformation:UILabel!
    var line:UIView!
    
    var informationContainer:UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellowColor()
    }
    
    func addUIComponents(){
        
    }

    func addUIConstraints(){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
