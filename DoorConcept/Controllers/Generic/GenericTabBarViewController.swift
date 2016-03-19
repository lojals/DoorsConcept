//
//  GenericTabBarViewController.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/18/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit

class GenericTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBar.configureFlatTabBarWithColor(UIColor.DCThemeColorContrastMain())
        self.tabBar.tintColor = UIColor.DCThemeColorMain()
        self.tabBar.translucent = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
