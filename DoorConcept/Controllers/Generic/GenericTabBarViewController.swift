//
//  GenericTabBarViewController.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/18/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit

class GenericTabBarViewController: UITabBarController {

    /**
     Solid background on tabBar and main color tint color.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor.DCThemeColorMain()
        self.tabBar.translucent = false
    }
}
