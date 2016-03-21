//
//  BuildingsTableViewController.swift
//  DoorConcept
//
//  Created by Jorge Raul Ovalle Zuleta on 3/18/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit
import SESlideTableViewCell
import CoreData

class BuildingsTableViewController: UITableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let newItem = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedObjectContext) as! User
//        newItem.userUsername = "Test.3"
//        newItem.userPassword = "123456"
//        newItem.userAvatar   = "1"
//        do{
//            try managedObjectContext.save()
//        }catch{
//            print("Some error inserting User")
//        }
        LoginService.sharedInstance.Login("Test.1", password: "123456") { (logged, error) -> Void in
            if logged{
                print("Logged In")
            }else{
                print(error!)
            }
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell               = tableView.dequeueReusableCellWithIdentifier("BuildingCell", forIndexPath: indexPath) as! BuildingsTableViewCell
        cell.delegate          = self
        cell.tag               = indexPath.row
        cell.imgBuilding.image = UIImage(named: "build_\(Int(arc4random_uniform(UInt32(5))))")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        return cell
    }
}


extension BuildingsTableViewController:SESlideTableViewCellDelegate{
    func slideTableViewCell(cell: SESlideTableViewCell!, didTriggerRightButton buttonIndex: Int) {
        print("\(buttonIndex) \(cell.tag)")
    }
}