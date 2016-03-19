//
//  BuildingsTableViewController.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/18/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit
import SESlideTableViewCell

class DoorsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell               = tableView.dequeueReusableCellWithIdentifier("DoorCell", forIndexPath: indexPath) as! DoorsTableViewCell
        if (!cell.isEqual(nil)){
            cell.delegate          = self
            cell.tag               = indexPath.row
            cell.imgDoor.image = UIImage(named: "door_\(Int(arc4random_uniform(UInt32(5))))")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        }
        
        return cell
    }
}


extension DoorsTableViewController:SESlideTableViewCellDelegate{
    func slideTableViewCell(cell: SESlideTableViewCell!, didTriggerRightButton buttonIndex: Int) {
        print("\(buttonIndex) \(cell.tag)")
    }
}