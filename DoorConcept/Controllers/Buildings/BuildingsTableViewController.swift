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
    let buildingInteractor = BuildingsInteractor()
    var buildings:[Building] = [Building]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        buildingInteractor.getBuildings { (data, error) -> Void in
            if error == nil{
                print(data?.count)
                self.buildings = data as! [Building]
                self.tableView.reloadData()
            }else{
                print(error)
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildings.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell      = tableView.dequeueReusableCellWithIdentifier("BuildingCell", forIndexPath: indexPath) as! BuildingsTableViewCell
        cell.delegate = self
        cell.tag      = indexPath.row
        cell.configureCellWithBuilding(buildings[indexPath.row])
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(segue.identifier)
    }
}


extension BuildingsTableViewController:SESlideTableViewCellDelegate{
    func slideTableViewCell(cell: SESlideTableViewCell!, didTriggerRightButton buttonIndex: Int) {
        print("\(buttonIndex) \(cell.tag)")
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let doorView      = self.storyboard?.instantiateViewControllerWithIdentifier("DoorsTableViewController") as! DoorsTableViewController
        doorView.building = buildings[indexPath.row]
        self.navigationController?.pushViewController(doorView, animated: true)
    }
}