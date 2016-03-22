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

    /**
     Solid background on navigation Bar and main color tint color.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.translucent = false
        self.navigationBar.tintColor = UIColor.DCThemeColorMain()
    }
}
