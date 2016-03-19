//
//  GenericNavigationController.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/18/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit
import FlatUIKit

class GenericNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationBar.configureFlatNavigationBarWithColor(UIColor.DCThemeColorContrastMain())
        self.navigationBar.translucent = false
        self.navigationBar.tintColor = UIColor.DCThemeColorMain()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
